#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "📦 Installing dependencies in all exercise folders..."
echo ""

for dir in */; do
    if [ -f "$dir/package.json" ]; then
        echo "➡️  $dir"
        (cd "$dir" && npm install --silent)
        echo "   ✅ Done"
    fi
done

echo ""
echo "✅ All dependencies installed!"
