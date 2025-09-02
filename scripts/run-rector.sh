#!/usr/bin/env bash
# Helper to run rector on staged PHP files

FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.php$')
if [ -z "$FILES" ]; then
    echo "No PHP files to process with rector."
    exit 0
fi

if [ -f "vendor/bin/rector" ]; then
    vendor/bin/rector process $FILES
else
    echo "rector not found in vendor/bin/"
    exit 1
fi
