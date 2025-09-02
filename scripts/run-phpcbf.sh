#!/usr/bin/env bash
# Helper to run phpcbf on staged PHP files

echo "Running PHP Code Beautifier and Fixer..."

FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.php$' || true)
if [ -z "$FILES" ]; then
    echo "No PHP files to process with phpcbf."
    exit 0
fi

if [ -f "vendor/bin/phpcbf" ]; then
    echo "Processing files: $FILES"
    vendor/bin/phpcbf $FILES
    
    # Re-add modified files to staging area
    for file in $FILES; do
        if [ -f "$file" ]; then
            git add "$file"
            echo "Re-staged: $file"
        fi
    done
else
    echo "phpcbf not found in vendor/bin/"
    exit 1
fi