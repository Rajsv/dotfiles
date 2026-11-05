#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Installation & Symlink Script
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "==> Setting up dotfiles from ${DOTFILES_DIR}..."

# 1. Zellij Configuration
mkdir -p "${HOME}/.config/zellij"
if [ -f "${HOME}/.config/zellij/config.kdl" ] && [ ! -L "${HOME}/.config/zellij/config.kdl" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up existing config.kdl to ${BACKUP_DIR}/config.kdl"
    mv "${HOME}/.config/zellij/config.kdl" "${BACKUP_DIR}/config.kdl"
fi
ln -sf "${DOTFILES_DIR}/zellij/config.kdl" "${HOME}/.config/zellij/config.kdl"
echo "✔ Symlinked ~/.config/zellij/config.kdl"

# 2. Zsh Configuration
if [ -f "${HOME}/.zshrc" ] && [ ! -L "${HOME}/.zshrc" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up existing .zshrc to ${BACKUP_DIR}/.zshrc"
    mv "${HOME}/.zshrc" "${BACKUP_DIR}/.zshrc"
fi
ln -sf "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
echo "✔ Symlinked ~/.zshrc"

# 3. Permissions & Scripts
chmod +x "${DOTFILES_DIR}/bin/"*.sh "${DOTFILES_DIR}/"*.sh 2>/dev/null || true
echo "✔ Permissions verified on bin and sync scripts"

# 4. Auto-update LaunchAgent setup
if [ -f "${HOME}/Library/LaunchAgents/com.raj.zellij-autoupdate.plist" ]; then
    launchctl unload "${HOME}/Library/LaunchAgents/com.raj.zellij-autoupdate.plist" 2>/dev/null || true
    launchctl load "${HOME}/Library/LaunchAgents/com.raj.zellij-autoupdate.plist" 2>/dev/null || true
    echo "✔ Registered auto-update LaunchAgent"
fi

echo "==> Dotfiles setup completed successfully!"
