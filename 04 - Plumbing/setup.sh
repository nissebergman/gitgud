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

# Clean up output files from previous runs
rm -f catfileout.txt blob.txt

# Create the content file with "sparre"
echo "sparre" > content.md

git init -b main

# Initial commit with project files (content.md has "sparre")
git add .gitignore README.md content.md package.json package-lock.json index.test.js run_tests.sh setup.sh
git commit -m "initial project setup"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commit created on main."
echo ""
echo "   Your task: use git cat-file to explore the commit, tree, and blob objects."
echo "   Write the results to catfileout.txt and blob.txt."
echo ""
