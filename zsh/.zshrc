# ==============================================================================
# Environment & Tooling Exports
# ==============================================================================
export ANTHROPIC_BASE_URL="http://localhost:11434/v1"
export ANTHROPIC_AUTH_TOKEN="ollama"

# Homebrew environment
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Added by Antigravity CLI installer & Antigravity IDE
export PATH="/Users/raj/.local/bin:$PATH"
export PATH="/Users/raj/.antigravity-ide/antigravity-ide/bin:$PATH"

# ==============================================================================
# FZF Visual Search & History Setup (Ctrl + R)
# ==============================================================================
if command -v fzf >/dev/null 2>&1; then
    # Load official fzf zsh integration (binds Ctrl+R, Ctrl+T, Alt+C)
    eval "$(fzf --zsh)"

    # Catppuccin Mocha themed visual styling for fzf
    export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --prompt='❯ ' --pointer='▶' --marker='✔ ' \
        --layout=reverse --border=rounded"

    # Enhanced Ctrl+R History Visual Search with full command preview
    export FZF_CTRL_R_OPTS=" \
        --prompt='Search History ❯ ' \
        --header='[Enter: Run] [Tab: Select] [Ctrl-C: Exit]' \
        --preview='echo {}' \
        --preview-window='down:3:wrap' \
        --height='45%'"
fi

# ==============================================================================
# Zellij Aliases & Helpers
# ==============================================================================
alias zj="zellij"
alias zja="zellij attach -c"
alias zjl="zellij list-sessions"
alias zjk="zellij kill-session"
alias zjka="zellij kill-all-sessions"
alias update-zellij="${HOME}/.dotfiles/bin/zellij-autoupdate.sh"

# ==============================================================================
# Zellij Auto-Launch on Shell Startup
# ==============================================================================
# Guards:
# 1. Terminal is interactive and connected to a TTY (-t 1 and $- == *i*)
# 2. Not already running inside Zellij ($ZELLIJ is empty)
# 3. Not inside an IDE integrated terminal (VS Code, Cursor, Antigravity)
# 4. Allows bypassing via `ZELLIJ_SKIP=1 zsh` or `NO_ZELLIJ=1`
if [[ -z "$ZELLIJ" && -z "$NO_ZELLIJ" && -z "$ZELLIJ_SKIP" && -z "$INTELLIJ_ENVIRONMENT_READER" && "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "cursor" && "$TERM_PROGRAM" != "antigravity" && -t 1 && $- == *i* ]]; then
    exec zellij attach -c main
fi
