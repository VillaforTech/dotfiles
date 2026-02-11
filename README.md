# Dotfiles

Minimal macOS (Apple Silicon) dotfiles for a terminal-centric development environment. Lives at `~/.config/dotfiles` and symlinks configs into place.

## Directory Structure

```
dotfiles/
├── nvim/                    # Neovim configuration
│   ├── init.lua             # Entry point: lazy.nvim bootstrap + theme resolution
│   ├── lazy-lock.json       # Pinned plugin versions
│   ├── lua/
│   │   ├── core/
│   │   │   ├── options.lua  # Editor settings (tabs, numbers, splits)
│   │   │   ├── keymaps.lua  # Global keybindings (leader=Space)
│   │   │   └── snippets.lua # Custom code snippets
│   │   ├── plugins/         # One file per plugin (lazy.nvim spec)
│   │   │   ├── themes/      # nord.lua, onedark.lua
│   │   │   └── ...          # ~23 plugin files
│   │   └── tools/
│   │       └── sql-runner.lua
├── zsh/                     # Zsh shell configuration
│   ├── .zshrc               # Minimal loader
│   ├── .zshenv              # Env vars, theme settings, PATH
│   ├── custom.zsh           # Shell init (pyenv, starship, fzf, zoxide, vi-mode)
│   ├── aliases.zsh          # 40+ aliases (git, AI tools, eza, navigation)
│   └── git-completion.*     # Git tab completion
├── tmux/                    # Tmux configuration
│   ├── tmux.conf            # Main config (prefix=Ctrl+Space)
│   ├── nord-theme.conf      # Nord status bar theme
│   └── onedark-theme.conf   # OneDark status bar theme
├── wezterm/                 # WezTerm terminal emulator
│   ├── wezterm.lua          # Entry point + theme resolution
│   ├── config.lua           # Font, keybindings, auto-tmux-attach
│   └── events.lua           # Auto-maximize on startup
├── starship/                # Starship prompt
│   └── starship.toml        # Prompt format, symbols, colors
├── ranger/                  # Ranger file manager
├── homebrew/                # Homebrew packages
│   └── Brewfile             # All formulae and casks
├── scripts/                 # Installation helpers
│   ├── utils.sh             # Colored output functions
│   ├── prerequisites.sh     # Xcode + Homebrew checks
│   ├── brew-install-custom.sh
│   ├── osx-defaults.sh      # macOS system preferences
│   └── symlinks.sh          # Symlink creation/deletion
├── symlinks.conf            # Symlink mappings (source:target)
└── install.sh               # Interactive installer
```

## Key Features

- **Unified Theme System** — All tools read theme env vars from `zsh/.zshenv` (`NVIM_THEME`, `TMUX_THEME`, `STARSHIP_THEME`, `WEZTERM_THEME`). Supported: `nord` (default), `onedark`.
- **Cross-Tool Navigation** — `Ctrl+hjkl` navigates seamlessly across Neovim splits and Tmux panes via vim-tmux-navigator.
- **Modular Neovim** — 23+ plugins managed by lazy.nvim, one file per plugin. LSP, autocompletion, formatting (conform.nvim), linting (nvim-lint), debugging (DAP), and Treesitter.
- **Rust Development** — rust-analyzer with clippy integration, codelldb debugger, cargo env in PATH.
- **FZF-Enhanced Git Workflow** — Interactive `git add`, `restore`, `checkout`, `branch` selection via fzf. LazyGit integration in Neovim.
- **AI Tool Aliases** — Quick access to Claude (`cc`), Codex (`cx`), and Gemini (`gmc`).
- **Vi-Mode Shell** — Zsh vi-mode with cursor shape switching (beam in insert, block in normal).

## Supported Tools

| Tool | Purpose | Notes |
|------|---------|-------|
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator | Lua config, auto-attaches tmux, auto-maximizes |
| [Zsh](https://www.zsh.org/) | Shell | Vi-mode, fzf, zoxide, syntax highlighting, autosuggestions |
| [Starship](https://starship.rs/) | Shell prompt | Nord/OneDark palette switching |
| [Neovim](https://neovim.io/) | Editor | lazy.nvim, LSP, DAP, Treesitter, conform, nvim-lint |
| [Tmux](https://github.com/tmux/tmux/wiki) | Terminal multiplexer | TPM, resurrect, continuum, vim-tmux-navigator |
| [Ranger](https://github.com/ranger/ranger) | File manager | Symlinked config |

## Requirements

- macOS (Apple Silicon, Homebrew at `/opt/homebrew`)
- Xcode Command Line Tools
- Homebrew

## Quick Start

```bash
git clone https://github.com/YOUR_USER/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
./install.sh
```

The installer prompts for:
1. **Install apps?** — Runs Homebrew to install packages from `homebrew/Brewfile`
2. **Overwrite existing dotfiles?** — Removes existing symlinks/files before creating new ones

## What Gets Changed

- Symlinks created from this repo to `~/.config/` and `~/`
- Homebrew packages installed (if selected)
- macOS defaults applied (Dock, Finder preferences)
- `~/.hushlogin` created (suppresses terminal login message)

## How Symlinks Work

Mappings are defined in `symlinks.conf`:
```
$(pwd)/nvim:$HOME/.config/nvim
$(pwd)/zsh/.zshrc:$HOME/.zshrc
```

Manual management:
```bash
./scripts/symlinks.sh --create   # Create symlinks
./scripts/symlinks.sh --delete   # Remove symlinks only
```

## Theme Configuration

Environment variables in `zsh/.zshenv` control theming across all tools:
- `NVIM_THEME` — Neovim colorscheme
- `TMUX_THEME` — Tmux status bar
- `STARSHIP_THEME` — Shell prompt palette
- `WEZTERM_THEME` — Terminal color scheme

Values: `nord` (default), `onedark`

## Maintenance

### Homebrew
```bash
brew bundle check --file=homebrew/Brewfile        # Check status
brew bundle --file=homebrew/Brewfile               # Install missing
brew bundle dump --file=homebrew/Brewfile --force   # Update Brewfile from installed
```

### Neovim Plugins
Managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Lock file: `nvim/lazy-lock.json`
```bash
nvim                    # Open nvim, lazy.nvim auto-installs
:Lazy update            # Update plugins
:Lazy restore           # Restore from lock file
```

### Tmux Plugins
```bash
tmux source ~/.config/tmux/tmux.conf   # Reload config
# Press prefix + I to install plugins via TPM
```

## Troubleshooting

```bash
# Verify symlinks work
./scripts/symlinks.sh --delete && ./scripts/symlinks.sh --create

# Test nvim config
nvim --headless "+quitall"

# Test tmux config
tmux -f tmux/tmux.conf new-session -d && tmux kill-server

# Brewfile issues
brew bundle check --file=homebrew/Brewfile
```

## What's NOT Included

This repo intentionally excludes VS Code, iTerm2, Kitty, Karabiner-Elements, Rectangle, Obsidian, DBeaver, and Vim configs.

## Adding New Dotfiles

1. Place config in appropriate directory
2. Add mapping to `symlinks.conf`
3. Run `./scripts/symlinks.sh --create`

## Documentation

- [docs/CONFIG_OVERVIEW.md](docs/CONFIG_OVERVIEW.md) — Detailed module explanations
- [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) — Consolidated keybindings reference
