#!/usr/bin/env bash
# Helper to run phpcbf on staged PHP files

FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.php$')
if [ -z "$FILES" ]; then
    echo "No PHP files to process with phpcbf."
    exit 0
fi

if [ -f "vendor/bin/phpcbf" ]; then
    vendor/bin/phpcbf $FILES
else
    echo "phpcbf not found in vendor/bin/"
    exit 1
fi
