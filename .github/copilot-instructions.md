# Copilot Instructions for githooks Project

## Overview
This project manages Git hooks using symlinks for easy installation and removal. The main entry point is the `setup` script, which automates adding and removing hooks in the repository's `.git/hooks` directory.

## Structure
- `setup` — Bash script to install/uninstall hooks via symlinks
- `hooks/` — Main directory for hook scripts
  - `pre-commit`, `pre-push`, `commit-msg` — Example hook scripts
- `scripts/` — Helper scripts directory
  - `run-rector.sh` — Runs rector on staged PHP files
  - `run-phpcbf.sh` — Runs phpcbf on staged PHP files

## Key Workflows
- **Install hooks:**
  ```bash
  ./setup install
  # or for specific repository:
  ./setup install --repository /path/to/repo
  ./setup install -R /path/to/repo
  ```
  This creates symlinks for all supported hooks from `hooks/` into `.git/hooks/`.
- **Uninstall hooks:**
  ```bash
  ./setup uninstall
  # or for specific repository:
  ./setup uninstall --repository /path/to/repo
  ./setup uninstall -R /path/to/repo
  ```
  This removes symlinks for all supported hooks from `.git/hooks/`.

## Conventions
- All main hook scripts should be placed directly in `hooks/` and be executable.
- Helper scripts go in `scripts/` and can be sourced from main hooks.
- Only hooks listed in the `HOOKS` array in `setup` are managed.
- Hook scripts can use Bash or other interpreters, but must have the correct shebang.

## Examples
- To add a new hook, create `hooks/<hook-name>` and add it to the `HOOKS` array in `setup`.
- To share logic, put reusable code in `scripts/` and source it from hook scripts.
- Use PHP helpers in pre-commit hook:
  ```bash
  # In hooks/pre-commit
  ./scripts/run-phpcbf.sh
  ./scripts/run-rector.sh
  ```

## Integration
- No external dependencies by default; all logic is in Bash scripts.
- The project is designed to be portable and not require extra installation steps.

## References
- See `setup` for install/uninstall logic.
- See `hooks/` for hook script examples and structure.

---
For questions or improvements, update this file to keep instructions current.
