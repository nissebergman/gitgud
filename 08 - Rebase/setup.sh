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

git init -b main

# Initial commit with project files
git add .gitignore README.md content.md package.json package-lock.json setup.sh
git commit -m "initial project setup"

# --- chore commits ---
echo "## Linting rules" > linting.md
echo "- Enable strict mode" >> linting.md
git add linting.md
git commit -m "chore: add linting configuration notes"

echo "## Dependency Updates" > deps.md
echo "- Bumped express to 4.19" >> deps.md
git add deps.md
git commit -m "chore: update dependency versions"

echo "## Cleanup" > cleanup.md
echo "- Removed unused imports" >> cleanup.md
git add cleanup.md
git commit -m "chore: remove unused imports"

# --- fix commits ---
echo "## Auth Fix" > auth-fix.md
echo "- Fixed token refresh loop" >> auth-fix.md
git add auth-fix.md
git commit -m "fix: resolve token refresh loop"

echo "## Null Check" > null-check.md
echo "- Added null guard to user lookup" >> null-check.md
git add null-check.md
git commit -m "fix: add null check for user lookup"

echo "## Timeout" > timeout-fix.md
echo "- Increased request timeout to 30s" >> timeout-fix.md
git add timeout-fix.md
git commit -m "fix: increase request timeout to 30s"

# --- ci commits ---
echo "## CI Cache" > ci-cache.md
echo "- Added node_modules caching step" >> ci-cache.md
git add ci-cache.md
git commit -m "ci: add node_modules caching step"

echo "## CI Notifications" > ci-notify.md
echo "- Added Slack notification on failure" >> ci-notify.md
git add ci-notify.md
git commit -m "ci: add Slack notification on failure"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup klar! $COMMIT_COUNT commits skapade (1 initial + 8 uppgiftscommits)."
echo ""
echo "   Du har 8 commits att squasha med interaktiv rebase:"
echo "   • 3 chore:-commits  →  squasha till 1"
echo "   • 3 fix:-commits    →  squasha till 1"
echo "   • 2 ci:-commits     →  squasha till 1"
echo ""
echo "   Kör 'git rebase -i HEAD~8' för att börja!"
echo ""
