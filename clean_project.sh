#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "🧹 Removing .git folders from all exercise subfolders..."
echo ""

for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo "   ❌ $dir .git"
        rm -rf "$dir/.git"
    fi
done

echo ""
echo "✅ .git folders nuked!"
