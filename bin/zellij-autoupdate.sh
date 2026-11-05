#!/usr/bin/env bash
# ==============================================================================
# Zellij Auto-Update Script
# Checks Homebrew for Zellij updates and installs them safely.
# ==============================================================================

set -euo pipefail

LOG_DIR="${HOME}/Library/Logs"
LOG_FILE="${LOG_DIR}/zellij-autoupdate.log"
mkdir -p "$LOG_DIR"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

if ! command -v brew >/dev/null 2>&1; then
    log "ERROR: Homebrew not found on PATH."
    exit 1
fi

CURRENT_VER=$(zellij --version 2>/dev/null || echo "not installed")
log "Checking for Zellij updates... (Current version: ${CURRENT_VER})"

# Update brew formula metadata silently
brew update --quiet >/dev/null 2>&1 || true

if brew outdated --formula | grep -qE '^zellij($|[[:space:]])'; then
    log "New Zellij update found. Upgrading via Homebrew..."
    brew upgrade zellij >> "$LOG_FILE" 2>&1
    NEW_VER=$(zellij --version 2>/dev/null || echo "unknown")
    log "SUCCESS: Zellij upgraded successfully to ${NEW_VER}!"
else
    log "Zellij is already at the latest version (${CURRENT_VER})."
fi
