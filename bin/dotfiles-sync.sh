#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Repository Auto-Sync
# Pulls latest settings from GitHub on first shell launch
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
LAST_SYNC_FILE="${DOTFILES_DIR}/.last_sync"
SYNC_INTERVAL=300 # minimum seconds between auto-syncs (5 minutes to prevent spamming)

# Support forcing sync via argument: `dotfiles-sync.sh --force`
FORCE=0
if [[ "${1:-}" == "--force" || "${1:-}" == "-f" ]]; then
    FORCE=1
fi

# Check throttle unless forced
if [[ "$FORCE" -eq 0 && -f "$LAST_SYNC_FILE" ]]; then
    NOW=$(date +%s)
    LAST_SYNC=$(stat -f "%m" "$LAST_SYNC_FILE" 2>/dev/null || echo 0)
    DIFF=$((NOW - LAST_SYNC))
    if [[ "$DIFF" -lt "$SYNC_INTERVAL" ]]; then
        # Synced recently, skip network check
        exit 0
    fi
fi

# Quick connectivity check to GitHub (timeout 2s)
if ! nc -z -G 2 github.com 443 2>/dev/null; then
    # Offline or cannot reach GitHub; silently skip
    exit 0
fi

# Touch last sync file now
touch "$LAST_SYNC_FILE"

cd "$DOTFILES_DIR"

# Fetch remote changes silently with a timeout
if git fetch --quiet --timeout=3 origin main 2>/dev/null; then
    LOCAL=$(git rev-parse HEAD 2>/dev/null || echo "")
    REMOTE=$(git rev-parse origin/main 2>/dev/null || echo "")

    if [[ -n "$LOCAL" && -n "$REMOTE" && "$LOCAL" != "$REMOTE" ]]; then
        echo "⚡ Remote dotfiles updates detected! Updating settings..."
        if git pull --ff-only --quiet origin main 2>/dev/null; then
            # Re-apply symlinks and permissions if any new files were added
            "${DOTFILES_DIR}/install.sh" >/dev/null 2>&1
            echo "✔ Dotfiles & Zellij settings updated to latest commit (${REMOTE:0:7})."
        else
            echo "⚠️ Could not fast-forward dotfiles. Local changes may exist."
        fi
    fi
fi
