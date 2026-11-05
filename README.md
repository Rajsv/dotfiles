# ⚡ Raj's Dotfiles (Zellij + Zsh + FZF)

Production-ready, battle-tested terminal setup featuring **Zellij** multiplexer, **Zsh**, **FZF** visual history search, and automated background updates.

---

## 🚀 Key Highlights

* **Zellij 0.45+ Multiplexer**: Configured with the **Catppuccin Mocha** theme, compact status bar, native macOS clipboard integration, and generous 50,000-line scrollback.
* **Proper Visual History Search (`Ctrl + R`)**: Integrated with `fzf` featuring interactive fuzzy matching, rounded borders, syntax preview, and instant navigation. Zellij keybindings do not hijack `Ctrl + R`.
* **Seamless Shortcuts**: Fast `Alt`-based pane/tab controls so you never have to waste keystrokes switching modes for common actions.
* **Auto-Launch on Shell Startup**: Automatically creates or attaches to the `main` Zellij session when you open your terminal, safely guarded against nested sessions and IDE integrated terminals.
* **Auto-Update**: Background macOS LaunchAgent (`com.raj.zellij-autoupdate`) checks Homebrew daily and upgrades Zellij automatically. Also includes an instant `update-zellij` alias.

---

## ⌨️ Shortcut Cheat Sheet

### 🔍 Search & History
| Shortcut | Context | Action |
| :--- | :--- | :--- |
| **`Ctrl + r`** | Shell / Terminal | **Interactive Visual History Search** (via `fzf` popup with preview) |
| **`Alt + /`** or **`Ctrl + f`** | Zellij (Any mode) | **Direct Visual Scrollback Search** (instantly search terminal buffer) |
| **`Alt + w`** | Zellij (Any mode) | **Visual Session Switcher** (floating session manager) |

### 🪟 Instant Pane Management (No Mode Switch Needed)
| Shortcut | Action |
| :--- | :--- |
| **`Alt + h`** / **`Alt + Left`** | Focus pane to the left |
| **`Alt + l`** / **`Alt + Right`** | Focus pane to the right |
| **`Alt + j`** / **`Alt + Down`** | Focus pane below |
| **`Alt + k`** / **`Alt + Up`** | Focus pane above |
| **`Alt + n`** | New pane (auto layout) |
| **`Alt + d`** | Split pane downwards (horizontal split) |
| **`Alt + r`** | Split pane to the right (vertical split) |
| **`Alt + z`** | **Zoom / Fullscreen toggle** (expand pane to full window) |
| **`Alt + q`** | Close current focused pane |
| **`Alt + f`** | Toggle floating pane view |
| **`Alt + e`** | Toggle between embedded and floating pane |
| **`Alt + +`** / **`Alt + -`** | Increase / Decrease pane size |

### 📑 Instant Tab Management
| Shortcut | Action |
| :--- | :--- |
| **`Alt + t`** | Open a new tab |
| **`Alt + 1` .. `Alt + 9`** | Jump directly to Tab 1 through 9 |
| **`Alt + [`** / **`Alt + ]`** | Cycle swap layouts (tiled, stacked, compact) |

### 🕹️ Modal Fallbacks (Standard Zellij)
| Shortcut | Mode |
| :--- | :--- |
| **`Ctrl + p`** | Pane Mode (`n` new, `d` down, `r` right, `x` close, `f` fullscreen) |
| **`Ctrl + t`** | Tab Mode (`n` new, `r` rename, `x` close, `1`-`9` jump) |
| **`Ctrl + n`** | Resize Mode (`h/j/k/l` or arrow keys) |
| **`Ctrl + h`** | Move Mode (re-position panes) |
| **`Ctrl + s`** | Scrollback Mode (`e` edit buffer in editor, `/` search) |
| **`Ctrl + o`** | Session Mode (`d` detach, `w` session manager) |
| **`Ctrl + g`** | Lock Mode (passes all keystrokes to inner app/vim) |

---

## 🛠️ Auto-Update & Maintenance

* **Automatic Repo Sync on Shell Launch**:
  Whenever you launch your terminal shell, `~/.dotfiles/bin/dotfiles-sync.sh` checks GitHub for updates, pulls changes, and refreshes your symlinks.
* **Manual Dotfiles Sync Command**:
  ```bash
  sync-dotfiles
  ```
* **Manual Zellij Binary Update Command**:
  ```bash
  update-zellij
  ```
* **Background Service**:
  A macOS launch agent is installed at `~/Library/LaunchAgents/com.raj.zellij-autoupdate.plist`. It runs daily at 12:00 PM and logs to `~/Library/Logs/zellij-autoupdate.log`.

---

## 🔌 Installation / Setup on a New Mac

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

To start a plain shell without launching Zellij:
```bash
NO_ZELLIJ=1 zsh
```
