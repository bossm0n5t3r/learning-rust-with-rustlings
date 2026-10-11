#!/bin/sh
set -eu

# Run from the project root: ./init-rustlings.sh
# Existing files are overwritten; .git is excluded, and optional settings are prompted.
# Re-running resets exercise files; review changes with git diff afterward.

command -v rustlings > /dev/null 2>&1 || {
    echo "rustlings is not installed. Run: cargo install rustlings --locked" >&2
    exit 1
}

PROJECT_ROOT="$(pwd)"
SETUP_DIR="$(mktemp -d)"

trap 'rm -rf "$SETUP_DIR"' 0
trap 'exit 130' INT
trap 'exit 143' TERM
trap 'exit 129' HUP

(
    cd "$SETUP_DIR"
    rustlings init
)

# Preserve the upstream MIT license and optionally add a copyright notice.
curl -fsSL \
    'https://raw.githubusercontent.com/rust-lang/rustlings/refs/heads/main/LICENSE' \
    -o "$SETUP_DIR/LICENSE.upstream"
COPYRIGHT_NOTICE=''
printf 'Copyright year (Enter to skip): '
IFS= read -r COPYRIGHT_YEAR || COPYRIGHT_YEAR=''
if [ -n "$COPYRIGHT_YEAR" ]; then
    printf 'Copyright holder (Enter to skip): '
    IFS= read -r COPYRIGHT_HOLDER || COPYRIGHT_HOLDER=''
    if [ -n "$COPYRIGHT_HOLDER" ]; then
        COPYRIGHT_NOTICE="Copyright (c) $COPYRIGHT_YEAR $COPYRIGHT_HOLDER"
    fi
fi
COPYRIGHT_NOTICE="$COPYRIGHT_NOTICE" awk '
    { print }
    /^Copyright / && !added && ENVIRON["COPYRIGHT_NOTICE"] != "" {
        print ENVIRON["COPYRIGHT_NOTICE"]
        added = 1
    }
' "$SETUP_DIR/LICENSE.upstream" > "$SETUP_DIR/rustlings/LICENSE"

# Enter or end-of-input preserves existing settings. Invalid answers are retried.
confirm_copy() {
    while :; do
        printf 'Copy %s (overwrite matching files)? [y/N] ' "$1"
        if ! IFS= read -r answer; then
            printf '\n'
            return 1
        fi
        case "$answer" in
            y | Y) return 0 ;;
            n | N | '') return 1 ;;
            *) printf 'Please enter y or n.\n' ;;
        esac
    done
}

set -- -a --ignore-times --exclude='/.git'
if ! confirm_copy '.vscode/'; then
    set -- "$@" --exclude='/.vscode'
fi
if ! confirm_copy '.gitignore'; then
    set -- "$@" --exclude='/.gitignore'
fi

rsync "$@" "$SETUP_DIR/rustlings/" "$PROJECT_ROOT/"

printf '\nRustlings initialized in %s\n' "$PROJECT_ROOT"
