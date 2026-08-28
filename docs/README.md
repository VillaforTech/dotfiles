# Documentation map

Executable configuration and automated tests are authoritative for behavior.
These documents explain the intent without publishing credentials, account
details, private project paths, or machine inventories.

## Architecture

- [Shell](architecture/shell.md): startup ownership, PATH, functions, and scoped environments.
- [Terminal and tmux](architecture/terminal-tmux.md): recovery shell, named sessions, persistence, and key ownership.
- [Neovim](architecture/neovim.md): plugin boundary and explicit trusted sessions.
- [Git](architecture/git.md): global workflow defaults that do not rewrite existing repositories.
- [Codex](architecture/codex.md): private live state, portable autonomy defaults, audit mode, and operator boundary.
- [Python and Jupyter](architecture/python-jupyter.md): uv ownership, the pinned shared tool, and project kernels.
- [Productivity](architecture/productivity.md): Rectangle, task/calendar, launcher, and browser ownership.
- [Automation](architecture/automation.md): connector, heartbeat, and private-knowledge boundaries.
- [Keybindings](KEYBINDINGS.md): consolidated binding reference.

## Workflows

- [Project start](workflows/project-start.md): private registry and `work <alias>` behavior.
- [Agent autonomy](workflows/agent-autonomy.md): what proceeds automatically and what remains a checkpoint.
- [New Mac](workflows/new-mac.md): reproducible install order and private-state restoration.
- [Research capture](workflows/research.md): Zotero, stable citekeys, exports, and Obsidian notes.
- [Configuration overview](CONFIG_OVERVIEW.md): detailed legacy inventory, corrected for the current v1 behavior.

## Authority rules

- `scripts/link-config` owns linking and conflict backups.
- `symlinks.conf` is data, never executable shell.
- `scripts/work` owns project-session creation.
- `scripts/with-dev-secrets` owns explicit subprocess-only Keychain loading.
- `scripts/install-jupyter-tool` recreates the locked shared Jupyter tool environment.
- `scripts/configure-rectangle` and `macos/rectangle-actions.txt` own the portable window-binding policy.
- `codex/` owns sanitized examples only; live machine and connector state stays private.
- `tmux/tmux.conf` owns the terminal multiplexer prefix and persistence policy.
- `nvim/lua/core/keymaps.lua` owns explicit session commands.
- No documentation command may kill the live tmux server or delete a regular configuration target.
