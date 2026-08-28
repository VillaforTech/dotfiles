# Dotfiles

macOS (Apple Silicon) dotfiles for a WezTerm, zsh, tmux, Neovim, and Codex workflow. The repository lives at `~/.config/dotfiles`; its linker previews by default and never deletes an existing target.

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
│   ├── .zshenv              # Minimal XDG + locale environment
│   ├── .zprofile             # Login PATH and Homebrew initialization
│   ├── custom.zsh           # Shell init (uv, starship, fzf, zoxide, vi-mode)
│   ├── aliases.zsh          # 40+ aliases (git, AI tools, eza, navigation)
│   └── git-completion.*     # Git tab completion
├── tmux/                    # Tmux configuration
│   ├── tmux.conf            # Main config (prefix=Ctrl+Space)
│   ├── nord-theme.conf      # Nord status bar theme
│   └── onedark-theme.conf   # OneDark status bar theme
├── wezterm/                 # WezTerm terminal emulator
│   ├── wezterm.lua          # Entry point + theme resolution
│   ├── config.lua           # Font, keybindings, login shell
│   └── events.lua           # Auto-maximize on startup
├── starship/                # Starship prompt
│   └── starship.toml        # Prompt format, symbols, colors
├── ranger/                  # Ranger file manager
├── homebrew/                # Homebrew packages
│   └── Brewfile             # Curated v1 desired state, not whole-machine inventory
├── macos/                   # Reproducible app preference inventories
├── codex/                   # Sanitized base/project examples and global guidance
├── scripts/                 # Installation helpers
│   ├── utils.sh             # Colored output functions
│   ├── prerequisites.sh     # Xcode + Homebrew checks
│   ├── brew-install-custom.sh
│   ├── osx-defaults.sh      # macOS system preferences
│   ├── link-config          # Dry-run, exact targets, private backups
│   ├── configure-rectangle  # Idempotent seven-shortcut Rectangle policy
│   ├── work                 # Named project tmux sessions
│   ├── with-dev-secrets     # Subprocess-only login Keychain loader
│   └── symlinks.sh          # Compatibility wrapper for link-config
├── symlinks.conf            # Symlink mappings (source:target)
└── install.sh               # Interactive installer
```

## Key Features

- **Unified Theme System** — Interactive shells expose theme variables to Neovim, tmux, Starship, and WezTerm. Supported: `nord` (default), `onedark`.
- **Cross-Tool Navigation** — `Ctrl+hjkl` navigates seamlessly across Neovim splits and Tmux panes via vim-tmux-navigator.
- **Modular Neovim** — lazy.nvim manages pinned LSP, completion, debugging,
  navigation, and Treesitter modules. Cwd sessions load only through the
  explicit trusted-session command. Local lockfile/plugin experiments remain
  outside this migration until reviewed separately.
- **Rust Development** — rust-analyzer with clippy integration, codelldb debugger, cargo env in PATH.
- **FZF-Enhanced Git Workflow** — Interactive `git add`, `restore`, `checkout`, `branch` selection via fzf. LazyGit integration in Neovim.
- **AI Tool Aliases** — Quick access to Claude (`cc`), Codex (`cx`), and Gemini (`gmc`).
- **Vi-Mode Shell** — Zsh vi-mode with cursor shape switching (beam in insert, block in normal).

## Supported Tools

| Tool | Purpose | Notes |
|------|---------|-------|
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator | Lua config, opens a recoverable login shell, auto-maximizes |
| [Zsh](https://www.zsh.org/) | Shell | Vi-mode, fzf, zoxide, syntax highlighting, autosuggestions |
| [Starship](https://starship.rs/) | Shell prompt | Nord/OneDark palette switching |
| [Neovim](https://neovim.io/) | Editor | lazy.nvim, LSP, DAP, Treesitter, explicit trusted sessions |
| [Tmux](https://github.com/tmux/tmux/wiki) | Terminal multiplexer | TPM, resurrect, continuum, vim-tmux-navigator |
| [Ranger](https://github.com/ranger/ranger) | File manager | Symlinked config |
| [Rectangle](https://rectangleapp.com/) | Window manager | Seven non-conflicting shortcuts; tracked idempotent setup |
| Codex | Project-scoped coding agent | Autonomous workspace base, explicit read-only audit and operator modes |

## Requirements

- macOS (Apple Silicon, Homebrew at `/opt/homebrew`)
- Xcode Command Line Tools
- Homebrew

## Quick Start

```bash
git clone https://github.com/YOUR_USER/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
git config core.hooksPath .githooks
./scripts/link-config --dry-run
./scripts/link-config --apply
```

If a target already exists, the linker refuses it. After reviewing the exact
preview, use `--apply --backup-existing` to move only those exact targets into
`~/.local/state/dotfiles/link-backups/<timestamp>/` before linking. The broader
`install.sh` remains available for an intentional new-Mac setup and separately
prompts before Homebrew or existing-target backup work.

After Homebrew installs Rectangle, quit the app and apply the tracked preference
policy once:

```bash
./scripts/configure-rectangle
```

Launch Rectangle afterward to grant Accessibility and verify its login item;
macOS permission prompts cannot be made portable in dotfiles.

## What Gets Changed

- Symlinks created from this repo to `~/.config/` and `~/`
- Homebrew packages installed (if selected)
- macOS defaults applied (Dock, Finder preferences)
- `~/.hushlogin` created (suppresses terminal login message)

## How Symlinks Work

Mappings use a non-executable format in `symlinks.conf`:
```
${DOTFILES_ROOT}/nvim:${HOME}/.config/nvim
${DOTFILES_ROOT}/zsh/.zshrc:${HOME}/.zshrc
```

Manual management:
```bash
./scripts/link-config --dry-run
./scripts/link-config --apply
./scripts/link-config --apply --backup-existing
```

## Theme Configuration

Interactive environment variables in `zsh/.zshrc` control theming across all tools:
- `NVIM_THEME` — Neovim colorscheme
- `TMUX_THEME` — Tmux status bar
- `STARSHIP_THEME` — Shell prompt palette
- `WEZTERM_THEME` — Terminal color scheme

Values: `nord` (default), `onedark`

## Maintenance

### Homebrew
```bash
brew bundle check --file=homebrew/Brewfile --no-upgrade  # Check desired state
brew bundle --file=homebrew/Brewfile                     # Install missing
brew bundle dump --file=/tmp/Brewfile.review             # Review installed drift
diff -u homebrew/Brewfile /tmp/Brewfile.review            # Curate changes manually
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
./scripts/link-config --dry-run

# Run isolated linker, shell, Git, WezTerm, tmux, and Neovim checks
./tests/run

# Brewfile issues
brew bundle check --file=homebrew/Brewfile
```

## What's NOT Included

This repo intentionally excludes application data, credentials, vault contents, and private project registries. `~/.config/work/projects.toml` is machine-private; only its example schema is tracked.

## Adding New Dotfiles

1. Place config in appropriate directory
2. Add mapping to `symlinks.conf`
3. Preview with `./scripts/link-config --dry-run`
4. Apply only after the exact target list is correct

## Documentation

- [docs/README.md](docs/README.md) — Documentation authority map and current architecture
- [docs/CONFIG_OVERVIEW.md](docs/CONFIG_OVERVIEW.md) — Legacy detailed inventory, being consolidated
- [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) — Consolidated keybindings reference
