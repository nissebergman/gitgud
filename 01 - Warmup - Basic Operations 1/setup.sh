#!/bin/bash
set -e

cd "$(dirname "$0")"

# Install dependencies
npm install --silent 2>/dev/null || true

# Check if there are already commits — if so, wipe and reinitialize
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
fi

# Remove files from previous runs
rm -f content.md

git init -b main

# Initial commit with project files
git add .gitignore README.md package.json package-lock.json run_tests.sh setup.sh
git commit -m "initial project setup"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commit created on main."
echo ""
echo "   Your task: modify content.md, stage, and commit."
echo ""
