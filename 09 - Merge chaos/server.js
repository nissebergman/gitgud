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
