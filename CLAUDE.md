# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Minimal macOS (Apple Silicon) dotfiles for a terminal-centric dev environment: WezTerm, Zsh, Neovim, Tmux, Starship, Ranger. Lives at `~/.config/dotfiles` and symlinks configs into place.

## Setup & Installation

```bash
./install.sh                          # Interactive: install apps + create symlinks
./scripts/symlinks.sh --create        # Create symlinks only
./scripts/symlinks.sh --delete        # Remove symlinks only
```

Symlink mappings are defined in `symlinks.conf` (source:target format). To add a new dotfile: place it in the appropriate directory, add a mapping to `symlinks.conf`, then run symlinks.sh.

## Architecture

### Unified Theme System

All tools read theme env vars from `zsh/.zshenv` — the single source of truth:
- `NVIM_THEME`, `TMUX_THEME`, `STARSHIP_THEME`, `WEZTERM_THEME`
- Supported values: `nord` (default), `onedark`
- Each tool conditionally loads its theme file based on its env var

### Neovim (`nvim/`)

- **Entry:** `init.lua` bootstraps lazy.nvim, loads core modules, resolves theme from `NVIM_THEME`
- **Core:** `lua/core/` — options (leader=Space, tabs=4), keymaps (jk=escape, Ctrl+hjkl=navigation), snippets
- **Plugins:** `lua/plugins/` — one file per plugin (lazy.nvim spec format), ~27 plugin files
- **Themes:** `lua/plugins/themes/` — isolated theme specs (nord.lua, onedark.lua) with transparency toggle (`<leader>bg`)
- **Custom tools:** `lua/tools/sql-runner.lua` — multi-backend SQL execution with visual mode support
- **LSPs configured via Mason:** lua_ls, pylsp, ruff, jsonls, sqlls, terraformls, and others in `plugins/lsp.lua`
- Plugins auto-install on first launch; lock file at `nvim/lazy-lock.json`

### Zsh (`zsh/`)

- `.zshrc` is a minimal loader that sources `custom.zsh`, `aliases.zsh`, and optional `work.zsh`
- `.zshenv` sets XDG dirs, theme vars, EDITOR=nvim, build flags, and loads `~/.env` secrets
- `custom.zsh` initializes: pyenv, poetry, starship, fzf+bat, zoxide, zsh-syntax-highlighting, zsh-autosuggestions, vi-mode with cursor shape switching
- `aliases.zsh` has 40+ git aliases (many fzf-enhanced), Claude Code shortcuts, eza-based ls, `quick_commit()` that extracts ticket IDs from branch names

### Tmux (`tmux/`)

- Prefix: `Ctrl+Space`. Splits: `\` horizontal, `-` vertical. Vi copy mode.
- Status bar at top, mouse enabled, base index 1
- Plugins via TPM: vim-tmux-navigator, resurrect, continuum (auto-save 15min)
- Theme loaded conditionally from `nord-theme.conf` or `onedark-theme.conf`

### WezTerm (`wezterm/`)

- Lua-based: `wezterm.lua` (entry) loads `config.lua` + `events.lua`
- Reads `WEZTERM_THEME` env var, maps to Gogh color scheme names
- Default program: `tmux attach || tmux` (auto-attaches to tmux on launch)
- Font: JetBrains Mono Bold 12.5pt, no tab bar, RESIZE-only decorations

### Cross-Tool Navigation

Ctrl+hjkl navigates seamlessly across Neovim splits and Tmux panes via vim-tmux-navigator (configured in both `tmux.conf` and nvim plugins).

## Homebrew

```bash
brew bundle check --file=homebrew/Brewfile        # Check status
brew bundle --file=homebrew/Brewfile               # Install missing
brew bundle dump --file=homebrew/Brewfile --force   # Update from installed
```

## Validation

```bash
nvim --headless "+quitall"                                    # Test nvim config
tmux -f tmux/tmux.conf new-session -d && tmux kill-server     # Test tmux config
./scripts/symlinks.sh --delete && ./scripts/symlinks.sh --create  # Reset symlinks
```

## Key Conventions

- One plugin per file in `nvim/lua/plugins/`
- Shell scripts use helper functions from `scripts/utils.sh` (info, warning, error, success)
- macOS system defaults (Dock, Finder, key repeat) are set in `scripts/osx-defaults.sh`
- Repo targets macOS with Homebrew at `/opt/homebrew`
