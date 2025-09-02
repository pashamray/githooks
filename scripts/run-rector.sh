#!/usr/bin/env bash
# Helper to run rector on staged PHP files

echo "Running Rector..."

FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.php$' || true)
if [ -z "$FILES" ]; then
    echo "No PHP files to process with rector."
    exit 0
fi

if [ -f "vendor/bin/rector" ]; then
    echo "Processing files: $FILES"
    vendor/bin/rector process $FILES
    
    # Re-add modified files to staging area
    for file in $FILES; do
        if [ -f "$file" ]; then
            git add "$file"
            echo "Re-staged: $file"
        fi
    done
else
    echo "rector not found in vendor/bin/"
    exit 1
fi