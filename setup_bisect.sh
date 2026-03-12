#!/bin/bash
set -e

BISECT_DIR="$(cd "$(dirname "$0")" && pwd)/07 - Bisect"
cd "$BISECT_DIR"

# Check if there are already commits — if so, wipe and reinitialize
if git log --oneline >/dev/null 2>&1; then
    echo "⚠️  Existing commits detected. Purging git history to start fresh..."
    rm -rf .git
    git init -b main
    echo ""
fi

# Remove files from previous runs
rm -f answer.txt

# --- The working version of index.js ---
WORKING_INDEX='// Calculator module used by the team
// This program must exit cleanly (exit code 0) when working correctly.

function add(a, b) {
	return a + b;
}

function subtract(a, b) {
	return a - b;
}

function multiply(a, b) {
	return a * b;
}

function divide(a, b) {
	if (b === 0) throw new Error("Division by zero");
	return a / b;
}

// Self-test: the program validates its own math
function runTests() {
	const results = [];

	results.push(add(2, 3) === 5);
	results.push(subtract(10, 4) === 6);
	results.push(multiply(3, 7) === 21);
	results.push(divide(20, 4) === 5);
	results.push(add(100, 200) === 300);
	results.push(multiply(0, 999) === 0);
	results.push(subtract(50, 50) === 0);

	if (results.every((r) => r === true)) {
		console.log("✅ All calculations correct!");
		process.exit(0);
	} else {
		console.error("❌ Generic program error 3000.");
		process.exit(1);
	}
}

runTests();'

# --- The bugged version (multiply returns a + b instead of a * b) ---
BUGGED_INDEX='// Calculator module used by the team
// This program must exit cleanly (exit code 0) when working correctly.

function add(a, b) {
	return a + b;
}

function subtract(a, b) {
	return a - b;
}

function multiply(a, b) {
	return a + b;
}

function divide(a, b) {
	if (b === 0) throw new Error("Division by zero");
	return a / b;
}

// Self-test: the program validates its own math
function runTests() {
	const results = [];

	results.push(add(2, 3) === 5);
	results.push(subtract(10, 4) === 6);
	results.push(multiply(3, 7) === 21);
	results.push(divide(20, 4) === 5);
	results.push(add(100, 200) === 300);
	results.push(multiply(0, 999) === 0);
	results.push(subtract(50, 50) === 0);

	if (results.every((r) => r === true)) {
		console.log("✅ All calculations correct!");
		process.exit(0);
	} else {
		console.error("❌ Generic program error 3000.");
		process.exit(1);
	}
}

runTests();'

# Assorted file names and content for filler commits
FILENAMES=("utils.md" "api.md" "database.md" "frontend.md" "backend.md" "auth.md" "logging.md" "cache.md" "queue.md" "metrics.md" "config.md" "testing.md" "docs.md" "ci.md" "deploy.md" "security.md" "performance.md" "refactor.md" "cleanup.md" "migration.md")

MESSAGES=("update documentation" "add module notes" "refactor comments" "improve structure" "update config notes" "add TODO items" "cleanup whitespace" "fix typo in docs" "add section header" "reorganize notes" "update version notes" "add architecture notes" "improve readability" "update references" "add examples" "expand documentation" "fix formatting" "update dependencies notes" "add troubleshooting guide" "revise guidelines")

# The commit number where the bug is introduced (0-indexed, out of 50 total)
BUG_COMMIT=22

# Commit 0: initial setup with working index.js
echo "$WORKING_INDEX" > index.js
git add .gitignore index.js README.md content.md package.json package-lock.json
git commit -m "initial project setup"

# Create 49 more commits (total = 50)
for i in $(seq 1 49); do
    # Pick a filler file and message
    FILE_IDX=$(( (i - 1) % ${#FILENAMES[@]} ))
    MSG_IDX=$(( (i - 1) % ${#MESSAGES[@]} ))
    FILENAME="${FILENAMES[$FILE_IDX]}"
    MESSAGE="${MESSAGES[$MSG_IDX]}"

    # Append content to the filler file
    echo "## Update $i" >> "$FILENAME"
    echo "- ${MESSAGE} (revision $i)" >> "$FILENAME"
    echo "" >> "$FILENAME"

    # At the bug commit, also swap in the bugged index.js
    if [ "$i" -eq "$BUG_COMMIT" ]; then
        echo "$BUGGED_INDEX" > index.js
        git add -A
        git commit -m "$MESSAGE"
        # Save the bad commit hash
        BAD_HASH=$(git rev-parse HEAD)
    else
        git add -A
        git commit -m "$MESSAGE"
    fi
done

# Write the bad commit hash to a hidden file (for the test to verify)
echo "$BAD_HASH" > .bad_commit
echo "$BAD_HASH" > /tmp/bisect_bad_commit

COMMIT_COUNT=$(git log --oneline | wc -l | tr -d ' ')
echo ""
echo "✅ Setup complete! $COMMIT_COUNT commits created."
echo "   A bug was introduced somewhere in the history."
echo "   Run 'node index.js' — it's broken! Use git bisect to find the culprit."
echo ""
