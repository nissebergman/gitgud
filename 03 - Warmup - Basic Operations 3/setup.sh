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
rm -f branch.md

git init -b main

# Commit 1: main.md with first line
echo "små grodorna små grodorna" > main.md
git add main.md .gitignore README.md package.json package-lock.json setup.sh index.test.js run_tests.sh
git commit -m "add main.md with lyrics"

echo ""
echo "✅ Setup klar! 1 commit på main."
echo ""
echo "   main.md innehåller: \"små grodorna små grodorna\""
echo ""
echo "   Din uppgift: skapa en branch, gör commits, mergea och ta bort branchen."
echo ""
