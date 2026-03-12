#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "🔄 Kör setup-skript i alla uppgiftsmappar..."
echo ""

for dir in */; do
    if [ -f "$dir/setup.sh" ]; then
        echo "➡️  $dir"
        (cd "$dir" && bash setup.sh)
        echo ""
    fi
done

echo "🧹 Tar bort .git-mappar från alla uppgiftsmappar..."
echo ""

for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo "   ❌ $dir.git"
        rm -rf "$dir/.git"
    fi
done

echo ""
echo "✅ Tasks resetted and .git folders nuked!"
