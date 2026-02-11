# Configuration Overview

Detailed explanation of each module, its architecture, key settings, and theme integration.

## WezTerm (`wezterm/`)

GPU-accelerated terminal emulator configured in Lua.

**Files:**
- `wezterm.lua` — Entry point. Reads `WEZTERM_THEME` env var, maps it to a Gogh color scheme (`Nord (Gogh)` or `One Dark (Gogh)`), and applies it.
- `config.lua` — Main settings: font, padding, keybindings, hyperlink rules, default program.
- `events.lua` — Startup event that auto-maximizes the window on launch.

**Key settings:**
- **Font:** JetBrains Mono Bold, 12.5pt
- **Decorations:** RESIZE-only (no title bar, no tab bar)
- **Default program:** `/bin/zsh -l -c "tmux attach || tmux"` — auto-attaches to an existing tmux session or creates one
- **Background:** Pure black (`#000000`) with macOS background blur
- **Keybindings:** `Ctrl+Enter` and `Shift+Enter` send distinct escape sequences for Neovim compatibility
- **Hyperlink rules:** Clickable URLs in parens, brackets, braces, angle brackets, and bare URLs

**Theme integration:** Reads `WEZTERM_THEME` from shell environment via `printenv`, maps to Gogh scheme names.

## Zsh (`zsh/`)

Shell configuration split into focused files, loaded by a minimal `.zshrc`.

**Files:**
- `.zshrc` — Loader that sources `custom.zsh`, `aliases.zsh`, and optional `work.zsh`
- `.zshenv` — Sets XDG directories, theme env vars (`NVIM_THEME`, `TMUX_THEME`, etc.), `EDITOR=nvim`, build flags (`LDFLAGS`, `CPPFLAGS`), locale, and loads `~/.env` secrets and `~/.cargo/env`
- `custom.zsh` — Shell initialization:
  - **Homebrew** setup at `/opt/homebrew`
  - **Pyenv** for Python version management
  - **Poetry** in PATH
  - **Starship** prompt init with theme palette switching
  - **Git completion** via custom zstyle + fpath
  - **FZF** with bat preview, hidden file search via ripgrep
  - **FZF functions:** `fd()` (cd to directory via fzf), `fh()` (search and execute from command history)
  - **Zoxide** (`z` command — smarter `cd`)
  - **zsh-syntax-highlighting** with path underline disabled
  - **zsh-autosuggestions**
  - **Vi-mode** with cursor shape switching (beam in insert mode, block in normal mode), system clipboard yank, and `v` in normal mode to edit command in Neovim
  - **`create_ds_project()`** — Interactive data science project scaffolding with pyenv, venv, and optional Jupyter
- `aliases.zsh` — 40+ aliases organized by category:
  - **System:** `shutdown`, `restart`, `sleep`, `c` (clear), `e` (exit)
  - **AI tools:** `cc` (claude), `cx` (codex auto), `cxr` (codex readonly), `cxn` (codex net), `gmc` (gemini sandbox)
  - **Git (30+ aliases):** Standard shortcuts (`ga`, `gc`, `gp`, `gco`, `gb`, `gd`, `gl`, etc.)
  - **FZF-enhanced git:** `gafzf` (add), `grmfzf` (rm), `grfzf` (restore), `grsfzf` (restore staged), `gcofzf` (checkout branch)
  - **`quick_commit()`** — Commits with ticket ID extracted from branch name (e.g., branch `PROJ-123-feature` → commit `PROJ-123: message`). `gqc` alias, `gqcp` to commit and push.
  - **Neovim:** `vi`/`v` → poetry-aware nvim launcher (runs `poetry run nvim` if in a Poetry project)
  - **Navigation:** `ls` → eza with icons, `r` → ranger, `lg` → lazygit, `lv`/`lv2`/`lv3`/`lv4` → go up directories
- `git-completion.bash` / `git-completion.zsh` — Git tab completion support

**Theme integration:** `.zshenv` is the single source of truth for all theme env vars. Starship palette is set via `starship config palette $STARSHIP_THEME`.

## Starship (`starship/`)

Cross-shell prompt with a single config file.

**Files:**
- `starship.toml` — Prompt format, module configuration, symbols, and color palettes (Nord and OneDark)

**Theme integration:** Initialized in `custom.zsh`. Palette selected via `starship config palette $STARSHIP_THEME`.

## Neovim (`nvim/`)

Lua-based configuration using lazy.nvim as the plugin manager.

**Entry point:** `init.lua` bootstraps lazy.nvim, loads core modules (`options`, `keymaps`, `snippets`), loads `tools/sql-runner`, resolves theme from `NVIM_THEME` env var (default: `nord`), and auto-restores `.session.vim` if present.

**Core modules:**
- `lua/core/options.lua` — Leader key: Space. Tabs: 4 spaces. Relative line numbers. System clipboard sync. Split below/right. No swap/backup files.
- `lua/core/keymaps.lua` — Global keybindings (see [KEYBINDINGS.md](KEYBINDINGS.md))
- `lua/core/snippets.lua` — Custom code snippets

### Plugins by Category

**UI & Appearance:**
| Plugin | File | Description |
|--------|------|-------------|
| Nord / OneDark | `themes/nord.lua`, `themes/onedark.lua` | Colorschemes with transparency toggle (`<leader>bg`) |
| lualine.nvim | `lualine.lua` | Status line with mode, branch, filename, diagnostics, diff |
| bufferline.nvim | `bufferline.lua` | Buffer tabs with vim-bbye for clean buffer deletion |
| alpha-nvim | `alpha.lua` | Dashboard/start screen with Neovim ASCII art |
| indent-blankline.nvim | `indent-blankline.lua` | Indent guide lines |
| nvim-colorizer.lua | `misc.lua` | Inline color highlighting |
| nvim-web-devicons | (dependency) | File type icons |

**Navigation & File Management:**
| Plugin | File | Description |
|--------|------|-------------|
| telescope.nvim | `telescope.lua` | Fuzzy finder for files, grep, buffers, git, LSP symbols, marks |
| neo-tree.nvim | `neo-tree.lua` | File tree sidebar and float with git status integration |
| oil.nvim | `oil.lua` | Edit filesystem like a buffer (parent dir with `-`) |
| harpoon | `harpoon.lua` | Quick file marks — pin files and jump between them |
| aerial.nvim | `aerial.lua` | Code outline / symbol navigation sidebar |
| vim-tmux-navigator | `vim-tmux-navigator.lua` | Seamless Ctrl+hjkl navigation between Neovim and Tmux |

**LSP, Completion & Formatting:**
| Plugin | File | Description |
|--------|------|-------------|
| nvim-lspconfig | `lsp.lua` | LSP client configuration with Mason auto-install |
| mason.nvim | (dependency) | LSP/tool installer |
| nvim-cmp | `autocompletion.lua` | Autocompletion with LSP, snippet, buffer, and path sources |
| LuaSnip | (dependency) | Snippet engine with friendly-snippets |
| conform.nvim | `conform.lua` | Format on save: stylua (Lua), ruff_format (Python), prettier (JS/TS/JSON/YAML/MD/HTML), shfmt (Bash), terraform_fmt |
| nvim-lint | `lint.lua` | Async linting: eslint_d (JS/TS), checkmake (Makefiles) |
| none-ls.nvim | `none-ls.lua` | Additional formatting/linting via null-ls (prettier, stylua, shfmt, ruff, checkmake) |
| fidget.nvim | (dependency) | LSP progress notifications |

**Configured LSP servers:** `lua_ls`, `pylsp`, `ruff`, `jsonls`, `sqlls`, `terraformls`, `yamlls`, `bashls`, `dockerls`, `docker_compose_language_service`, `html`, `rust_analyzer` (with clippy as check command)

**Git:**
| Plugin | File | Description |
|--------|------|-------------|
| lazygit.nvim | `lazygit.lua` | LazyGit floating window inside Neovim |
| gitsigns.nvim | `gitsigns.lua` | Git gutter signs (+, ~, _) for added/changed/deleted lines |
| vim-fugitive | `misc.lua` | Git commands inside Neovim (`:Git`, `:Gblame`, etc.) |
| vim-rhubarb | `misc.lua` | GitHub integration for vim-fugitive |

**Debugging:**
| Plugin | File | Description |
|--------|------|-------------|
| nvim-dap | `debug.lua` | Debug Adapter Protocol client |
| nvim-dap-ui | (dependency) | Debugger UI with variables, breakpoints, call stack |
| mason-nvim-dap | (dependency) | Auto-install debug adapters |
| nvim-dap-python | (dependency) | Python debugger (debugpy) |
| codelldb | (installed) | Rust/C/C++ debugger via LLDB |

**Editing & Utilities:**
| Plugin | File | Description |
|--------|------|-------------|
| nvim-treesitter | `treesitter.lua` | Syntax highlighting, indentation, incremental selection, text objects, motions |
| nvim-treesitter-textobjects | (dependency) | Function/class text objects (`af`, `if`, `ac`, `ic`) and motions (`]m`, `[m`) |
| Comment.nvim | `comment.lua` | Toggle comments with `Ctrl+/` or `Ctrl+c` |
| nvim-autopairs | `misc.lua` | Auto-close parentheses, brackets, quotes |
| nvim-ts-autotag | `misc.lua` | Auto-close/rename HTML tags |
| vim-sleuth | `misc.lua` | Auto-detect tabstop and shiftwidth |
| which-key.nvim | `misc.lua` | Keybinding hints popup (3s delay) |
| todo-comments.nvim | `misc.lua` | Highlight TODO, FIXME, NOTE in comments |
| vim-bbye | (dependency) | Clean buffer deletion without closing windows |

**Database:**
| Plugin | File | Description |
|--------|------|-------------|
| vim-dadbod | `database.lua` | Database interaction from Neovim |
| vim-dadbod-ui | (dependency) | Database explorer UI sidebar |
| vim-dadbod-completion | (dependency) | SQL autocompletion |

**Custom Tools:**
- `lua/tools/sql-runner.lua` — Multi-backend SQL execution with visual mode support

**Theme integration:** `init.lua` reads `NVIM_THEME`, imports the matching theme from `plugins/themes/`. Lualine also reads `NVIM_THEME` to match its status line theme.

## Tmux (`tmux/`)

Terminal multiplexer configuration.

**Files:**
- `tmux.conf` — Main configuration
- `nord-theme.conf` / `onedark-theme.conf` — Status bar themes

**Key settings:**
- **Prefix:** `Ctrl+Space` (rebound from default `Ctrl+b`)
- **Splits:** `\` horizontal, `-` vertical (both open in current path)
- **New window:** `c` (opens in current path)
- **Pane resize:** `hjkl` with prefix (5 units each)
- **Maximize pane:** `m` with prefix
- **Copy mode:** Vi keys. `v` to select, `y` to copy (pbcopy), `P` to paste
- **Mouse:** Enabled
- **Status bar:** Top position, 3-second refresh interval
- **Base index:** 1 (windows and panes start at 1)
- **Escape time:** 0 (no delay for Neovim ESC)
- **History:** 1,000,000 lines

**Plugins (via TPM):**
| Plugin | Purpose |
|--------|---------|
| vim-tmux-navigator | Ctrl+hjkl navigation between Neovim and Tmux panes |
| tmux-resurrect | Persist sessions across computer restarts (captures pane contents) |
| tmux-continuum | Auto-saves sessions every 15 minutes |
| tmux-cpu-mem-monitor | CPU and memory info in status bar |

**Theme integration:** Conditionally loads `nord-theme.conf` or `onedark-theme.conf` based on `TMUX_THEME` env var.

## Ranger (`ranger/`)

Terminal file manager. Python-based config symlinked to `~/.config/ranger`. Contains `rc.conf` and other ranger settings.

## Scripts (`scripts/`)

Helper scripts for installation and system setup.

| Script | Purpose |
|--------|---------|
| `utils.sh` | Colored output helper functions: `info()`, `warning()`, `error()`, `success()` |
| `prerequisites.sh` | Checks for Xcode Command Line Tools and Homebrew, installs if missing |
| `brew-install-custom.sh` | Runs `brew bundle` with the Brewfile |
| `osx-defaults.sh` | Sets macOS system preferences (Dock auto-hide, Finder defaults, key repeat speed, etc.) |
| `symlinks.sh` | Creates or deletes symlinks based on `symlinks.conf`. Flags: `--create`, `--delete` |

## Homebrew (`homebrew/`)

Package definitions.

- `Brewfile` — All brew formulae, casks, and Mac App Store apps to install. Managed with `brew bundle`.
