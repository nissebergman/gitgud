#!/bin/bash
set -e

cd "$(dirname "$0")"

# Install dependencies
npm install --silent 2>/dev/null || true

# Wipe and reinitialize if needed
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
    # Clean up generated files from previous runs
    rm -f server.js config.json auth.js api.js database.js
fi

git init -b main

# ─────────────────────────────────────────────
# BASE FILES ON MAIN
# ─────────────────────────────────────────────

cat > server.js << 'SERVERJS'
const express = require("express");
const app = express();

// Middleware
app.use(express.json());

// Database connection
const db = {
  host: "localhost",
  port: 5432,
  connect: function () {
    console.log(`Connecting to database at ${this.host}:${this.port}`);
    return true;
  },
};

// Routes
app.get("/api/users", (req, res) => {
  const users = [
    { id: 1, name: "Alice" },
    { id: 2, name: "Bob" },
  ];
  res.json(users);
});

app.get("/api/status", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.message);
  res.status(500).json({ error: "Internal server error" });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  db.connect();
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
SERVERJS

cat > config.json << 'CONFIGJSON'
{
  "server": {
    "port": 3000,
    "host": "0.0.0.0"
  },
  "database": {
    "host": "localhost",
    "port": 5432,
    "name": "myapp"
  },
  "logging": {
    "level": "info",
    "format": "json"
  }
}
CONFIGJSON

git add .gitignore README.md content.md package.json package-lock.json server.js config.json index.test.js run_tests.sh setup.sh
git commit -m "initial project setup"

# ─────────────────────────────────────────────
# BRANCH: feature/auth
# ─────────────────────────────────────────────

git checkout -b feature/auth

cat > auth.js << 'AUTHJS'
const JWT_SECRET = "super-secret-key";

function verifyToken(token) {
  if (token === "valid-token") return { username: "admin" };
  return null;
}

function generateToken(payload) {
  return "valid-token";
}

module.exports = { verifyToken, generateToken };
AUTHJS

cat > server.js << 'SERVERJS'
const express = require("express");
const app = express();
const { verifyToken, generateToken } = require("./auth");

// Middleware
app.use(express.json());

// Authentication middleware
const authenticate = (req, res, next) => {
  const token = req.headers.authorization;
  if (!token) return res.status(401).json({ error: "No token provided" });
  const user = verifyToken(token);
  if (!user) return res.status(403).json({ error: "Invalid token" });
  req.user = user;
  next();
};

// Database connection
const db = {
  host: "localhost",
  port: 5432,
  connect: function () {
    console.log(`Connecting to database at ${this.host}:${this.port}`);
    return true;
  },
};

// Routes
app.post("/api/login", (req, res) => {
  const { username, password } = req.body;
  if (username === "admin" && password === "secret") {
    const token = generateToken({ username });
    res.json({ token });
  } else {
    res.status(401).json({ error: "Invalid credentials" });
  }
});

app.get("/api/users", authenticate, (req, res) => {
  const users = [
    { id: 1, name: "Alice", role: "admin" },
    { id: 2, name: "Bob", role: "user" },
  ];
  res.json(users);
});

app.get("/api/status", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.message);
  res.status(500).json({ error: "Internal server error" });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  db.connect();
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
SERVERJS

cat > config.json << 'CONFIGJSON'
{
  "server": {
    "port": 3000,
    "host": "0.0.0.0"
  },
  "database": {
    "host": "localhost",
    "port": 5432,
    "name": "myapp"
  },
  "auth": {
    "jwtSecret": "super-secret-key",
    "tokenExpiry": "24h"
  },
  "logging": {
    "level": "info",
    "format": "json"
  }
}
CONFIGJSON

git add -A
git commit -m "feat: add authentication system"

# ─────────────────────────────────────────────
# BRANCH: feature/api
# ─────────────────────────────────────────────

git checkout main
git checkout -b feature/api

cat > api.js << 'APIJS'
function validateRequest(req, res, next) {
  req.requestId = Math.random().toString(36).substring(7);
  next();
}

function paginate(items, page, limit) {
  page = Number(page) || 1;
  limit = Number(limit) || 10;
  const start = (page - 1) * limit;
  const end = start + limit;
  return {
    data: items.slice(start, end),
    page: page,
    limit: limit,
    total: items.length,
  };
}

module.exports = { validateRequest, paginate };
APIJS

cat > server.js << 'SERVERJS'
const express = require("express");
const app = express();
const { validateRequest, paginate } = require("./api");

// Middleware
app.use(express.json());
app.use(validateRequest);

// Database connection
const db = {
  host: "localhost",
  port: 5432,
  connect: function () {
    console.log(`Connecting to database at ${this.host}:${this.port}`);
    return true;
  },
};

// Routes
app.get("/api/users", (req, res) => {
  const users = [
    { id: 1, name: "Alice" },
    { id: 2, name: "Bob" },
    { id: 3, name: "Charlie" },
    { id: 4, name: "Diana" },
  ];
  const result = paginate(users, req.query.page, req.query.limit);
  res.json(result);
});

app.get("/api/products", (req, res) => {
  const products = [
    { id: 1, name: "Widget", price: 9.99 },
    { id: 2, name: "Gadget", price: 24.99 },
  ];
  res.json({ data: products, total: products.length });
});

app.get("/api/status", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime(), version: "2.0.0" });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: err.message || "Internal server error",
    code: err.code || "INTERNAL_ERROR",
  });
});

// Start server
const PORT = 4000;
app.listen(PORT, () => {
  db.connect();
  console.log(`API server v2.0.0 running on port ${PORT}`);
});

module.exports = app;
SERVERJS

cat > config.json << 'CONFIGJSON'
{
  "server": {
    "port": 4000,
    "host": "0.0.0.0"
  },
  "database": {
    "host": "localhost",
    "port": 5432,
    "name": "myapp"
  },
  "api": {
    "rateLimit": 100,
    "pageSize": 20
  },
  "logging": {
    "level": "debug",
    "format": "json"
  }
}
CONFIGJSON

git add -A
git commit -m "feat: add API improvements and products endpoint"

# ─────────────────────────────────────────────
# BRANCH: feature/database
# ─────────────────────────────────────────────

git checkout main
git checkout -b feature/database

cat > database.js << 'DBJS'
function createPool(config) {
  return {
    host: config.host,
    port: config.port,
    database: config.database,
    maxConnections: config.maxConnections || 5,
    connected: true,
  };
}

async function query(pool, sql) {
  if (!pool.connected) throw new Error("Not connected to database");
  if (sql === "SELECT 1") return [{ result: 1 }];
  if (sql === "SELECT * FROM users") {
    return [
      { id: 1, name: "Alice" },
      { id: 2, name: "Bob" },
    ];
  }
  return [];
}

module.exports = { createPool, query };
DBJS

cat > server.js << 'SERVERJS'
const express = require("express");
const app = express();
const { createPool, query } = require("./database");

// Middleware
app.use(express.json());

// Database connection pool
const pool = createPool({
  host: "db.internal",
  port: 5432,
  database: "myapp",
  maxConnections: 10,
});

// Routes
app.get("/api/users", async (req, res) => {
  try {
    const users = await query(pool, "SELECT * FROM users");
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: "Database query failed" });
  }
});

app.get("/api/status", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

app.get("/api/health", async (req, res) => {
  try {
    await query(pool, "SELECT 1");
    res.json({ database: "connected", status: "healthy" });
  } catch (err) {
    res.status(503).json({ database: "disconnected", status: "unhealthy" });
  }
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.message);
  res.status(500).json({ error: "Internal server error" });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log("Database pool initialized");
});

module.exports = app;
SERVERJS

cat > config.json << 'CONFIGJSON'
{
  "server": {
    "port": 3000,
    "host": "0.0.0.0"
  },
  "database": {
    "host": "db.internal",
    "port": 5432,
    "name": "myapp",
    "poolSize": 10,
    "ssl": true
  },
  "logging": {
    "level": "info",
    "format": "json"
  }
}
CONFIGJSON

git add -A
git commit -m "feat: add database connection pooling"

# ─────────────────────────────────────────────
# Back to main — ready for the user
# ─────────────────────────────────────────────

git checkout main

echo ""
echo "✅ Setup klar!"
echo ""
echo "   Branches skapade:"
echo "   • feature/auth     — autentiseringssystem + /api/login"
echo "   • feature/api      — paginering, /api/products, ny error handler"
echo "   • feature/database  — connection pooling, asynkrona queries, /api/health"
echo ""
echo "   Alla tre branches ändrar server.js och config.json på motstridiga sätt."
echo "   Mergea alla tre till main och lös varje konflikt!"
echo ""
echo "   Börja med: git merge feature/auth"
echo ""
