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

# Clean up files from previous runs
rm -f A.md B.md C.md

git init -b main

# Initial commit with project files
git add .gitignore README.md content.md package.json package-lock.json setup.sh index.test.js run_tests.sh
git commit -m "initial project setup"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commit created on main."
echo ""
echo "   Your task:"
echo "   1. Create a 'feature' branch"
echo "   2. On 'feature', make 3 commits: A: (A.md), B: (B.md), C: (C.md)"
echo "   3. Switch to main and cherry-pick only the B: commit"
echo ""
