#!/bin/bash
set -e

cd "$(dirname "$0")"

# Check if there are already commits — if so, wipe and reinitialize
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
fi

git init -b main

# Commit 1: main.md with first line
echo "små grodorna små grodorna" > main.md
git add main.md
git commit -m "add main.md with lyrics"

# Create branch and switch to it
git checkout -b branch

# Commit 2: add branch.md
echo "en sockerbagare han bor i staden" > branch.md
git add branch.md
git commit -m "add branch.md with lyrics"

# Commit 3: update main.md with new line
echo "är lustiga att se" >> main.md
git add main.md
git commit -m "update main.md with more lyrics"

# Switch back to main
git checkout main

COMMIT_COUNT=$(git log --oneline --all | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commits created."
echo ""
echo "   main branch: 1 commit (main.md: \"små grodorna små grodorna\")"
echo "   branch: 2 additional commits (branch.md + main.md update)"
echo ""
echo "   Your task: merge 'branch' into 'main' and delete the branch."
echo ""
