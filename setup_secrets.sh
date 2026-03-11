#!/bin/bash
set -e

SECRETS_DIR="$(cd "$(dirname "$0")" && pwd)/06 - Secrets"
cd "$SECRETS_DIR"

# Check if there are already commits — if so, wipe and reinitialize
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
    git init -b main
    echo ""
fi

# Commit 1: initial setup
git add .gitignore content.md README.md package.json package-lock.json
git commit -m "initial project setup"

# Commit 2: add team members
cat > team.md << 'EOF'
# Team Members
- Alice
- Bob
EOF
git add team.md
git commit -m "add team members list"

# Commit 3: add project notes
cat > notes.md << 'EOF'
# Project Notes
- Setup CI pipeline
- Configure linting
- Add deployment docs
EOF
git add notes.md
git commit -m "add project notes"

# Commit 4: THE SECRET — add config with a leaked API key
cat > config.env << 'EOF'
DATABASE_URL=postgres://localhost:5432/mydb
API_BASE_URL=https://api.example.com
GITHUB_TOKEN=ghp_s3cr3tK3y9x7Qm2Lp4Rv8Tw1Yz6Bh0Jf
LOG_LEVEL=info
EOF
git add config.env
git commit -m "add environment config"

# Commit 5: update team
echo "- Charlie" >> team.md
git add team.md
git commit -m "add Charlie to team"

# Commit 6: add deployment guide
cat > deploy.md << 'EOF'
# Deployment Guide
1. Run tests
2. Build artifacts
3. Deploy to staging
4. Run smoke tests
5. Promote to production
EOF
git add deploy.md
git commit -m "add deployment guide"

# Commit 7: update notes
echo "- Write API documentation" >> notes.md
git add notes.md
git commit -m "update project notes with API docs task"

# Commit 8: add changelog
cat > CHANGELOG.md << 'EOF'
# Changelog

## v0.1.0
- Initial project setup
- Added team list
- Added deployment guide
EOF
git add CHANGELOG.md
git commit -m "add changelog"

# Commit 9: update team again
echo "- Diana" >> team.md
git add team.md
git commit -m "add Diana to team"

# Commit 10: update deployment guide
echo "6. Monitor metrics" >> deploy.md
git add deploy.md
git commit -m "add monitoring step to deploy guide"

# Commit 11: "remove" the secret by replacing with placeholder
cat > config.env << 'EOF'
DATABASE_URL=postgres://localhost:5432/mydb
API_BASE_URL=https://api.example.com
GITHUB_TOKEN=your-token-here
LOG_LEVEL=info
EOF
git add config.env
git commit -m "remove hardcoded token from config"

# Commit 12: update changelog
cat >> CHANGELOG.md << 'EOF'

## v0.2.0
- Removed hardcoded secrets
- Updated team roster
- Added monitoring to deploy
EOF
git add CHANGELOG.md
git commit -m "update changelog for v0.2.0"

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commits created."
echo "   A secret is buried in the git history. Can you find and purge it?"
echo ""
