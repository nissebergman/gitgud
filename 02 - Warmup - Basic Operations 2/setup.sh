#!/bin/bash
set -e

cd "$(dirname "$0")"

# Check if there are already commits — if so, wipe and reinitialize
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
fi

git init -b main

# Initial commit with project files
git add .gitignore README.md content.md package.json
git commit -m "initial project setup"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commit created on main."
echo ""
echo "   Your task:"
echo "   • Create branch 'first-branch' with a commit starting with 'A:'"
echo "   • Create branch 'second-branch' with a commit starting with 'B:'"
echo ""
