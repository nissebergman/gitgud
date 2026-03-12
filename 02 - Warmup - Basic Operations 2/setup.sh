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

# Remove files from previous runs (student-created files on branches)
find . -maxdepth 1 -type f -name '*.md' ! -name 'README.md' ! -name 'content.md' -delete 2>/dev/null || true

git init -b main

# Initial commit with project files
git add .gitignore README.md content.md package.json package-lock.json setup.sh
git commit -m "initial project setup"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup klar! $COMMIT_COUNT commit på main."
echo ""
echo "   Din uppgift:"
echo "   • Skapa branch 'first-branch' med en commit som börjar med 'A:'"
echo "   • Skapa branch 'second-branch' med en commit som börjar med 'B:'"
echo ""
