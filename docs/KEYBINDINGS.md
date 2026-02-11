# Consolidated Keybindings

**Leader Key:** `<Space>` (Neovim)
**Prefix Key:** `Ctrl + Space` (Tmux)

## 1. Cross-Tool Navigation

*Works seamlessly across Neovim splits and Tmux panes via vim-tmux-navigator.*

| Key | Action | Source |
| :--- | :--- | :--- |
| `Ctrl+h` | Navigate left | `vim-tmux-navigator.lua` |
| `Ctrl+j` | Navigate down | `vim-tmux-navigator.lua` |
| `Ctrl+k` | Navigate up | `vim-tmux-navigator.lua` |
| `Ctrl+l` | Navigate right | `vim-tmux-navigator.lua` |
| `Ctrl+\` | Navigate to previous pane | `vim-tmux-navigator.lua` |

## 2. Neovim Core

*Source: `lua/core/keymaps.lua`*

### General

| Key | Action |
| :--- | :--- |
| `<Esc>` | Clear search highlights |
| `<C-s>` | Save file |
| `<leader>sn` | Save file without auto-formatting |
| `<C-q>` | Quit buffer |
| `jk` / `kj` | Exit insert mode |
| `x` | Delete character (without yanking) |
| `<leader>j` | Replace word under cursor |
| `<leader>lw` | Toggle line wrapping |

### Scrolling & Search

| Key | Action |
| :--- | :--- |
| `<C-d>` | Scroll down half page (centered) |
| `<C-u>` | Scroll up half page (centered) |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |

### Buffers

| Key | Action |
| :--- | :--- |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer (Bdelete) |
| `<leader>b` | New empty buffer |

### Splits

| Key | Action |
| :--- | :--- |
| `<leader>v` | Split vertically |
| `<leader>h` | Split horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>xs` | Close current split |
| `<Up>` | Decrease split height |
| `<Down>` | Increase split height |
| `<Left>` | Decrease split width |
| `<Right>` | Increase split width |

### Tabs

| Key | Action |
| :--- | :--- |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |

### Increment / Decrement

| Key | Action |
| :--- | :--- |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |

### Clipboard

| Key | Action |
| :--- | :--- |
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank entire line to system clipboard |
| `p` (visual) | Paste without overwriting register |

### Visual Mode

| Key | Action |
| :--- | :--- |
| `<` / `>` | Indent/outdent (stays in visual mode) |
| `<Alt-j>` | Move selection down |
| `<Alt-k>` | Move selection up |

### Diagnostics

| Key | Action |
| :--- | :--- |
| `<leader>do` | Toggle diagnostics on/off |
| `<leader>d` | Open floating diagnostic |
| `<leader>q` | Open diagnostics list (loclist) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Sessions

| Key | Action |
| :--- | :--- |
| `<leader>ss` | Save session to `.session.vim` |
| `<leader>sl` | Load session from `.session.vim` |

## 3. Neovim Telescope

*Source: `lua/plugins/telescope.lua`*

### File Search

| Key | Action |
| :--- | :--- |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep (search text) |
| `<leader>sw` | Search current word under cursor |
| `<leader>so` | Search recent/old files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files only |
| `<leader>sb` | Search buffers |
| `<leader><leader>` | Search buffers (alt) |
| `<leader><tab>` | Search buffers (alt) |
| `<leader>sh` | Search help tags |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>sm` | Search marks |
| `<leader>sds` | Search LSP document symbols (filtered) |

### Git (Telescope)

| Key | Action |
| :--- | :--- |
| `<leader>gf` | Search git files |
| `<leader>gc` | Search git commits |
| `<leader>gcf` | Search git commits for current file |
| `<leader>gb` | Search git branches |
| `<leader>gs` | Search git status (diff view) |

### Inside Telescope

| Key | Action |
| :--- | :--- |
| `<C-j>` | Move to next result |
| `<C-k>` | Move to previous result |
| `<C-l>` | Open selected file |
| `q` (normal) | Close Telescope |
| `d` (buffers, normal) | Delete buffer |
| `l` (buffers, normal) | Open buffer |

## 4. Neovim File Explorer

### Neo-tree

*Source: `lua/plugins/neo-tree.lua` (keys on nvim-window-picker)*

| Key | Action |
| :--- | :--- |
| `<leader>e` | Toggle sidebar file explorer |
| `<leader>w` | Toggle floating file explorer |
| `<leader>ngs` | Open git status in float |
| `\` | Reveal current file in Neo-tree |

**Inside Neo-tree:**

| Key | Action |
| :--- | :--- |
| `<Space>` | Toggle node |
| `<CR>` / `l` | Open file |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `w` | Open with window picker |
| `P` | Toggle preview (float) |
| `C` | Close node |
| `z` | Close all nodes |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy file |
| `m` | Move file |
| `q` | Close window |
| `R` | Refresh |
| `?` | Show help |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `D` | Fuzzy finder (directories) |
| `[g` / `]g` | Previous/next git modified |
| `<` / `>` | Previous/next source |
| `i` | Show file details |

### Oil

*Source: `lua/plugins/oil.lua`*

| Key | Action |
| :--- | :--- |
| `-` | Open parent directory (Oil) |
| `<CR>` | Open file/directory |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-p>` | Preview |
| `<C-c>` | Close Oil |
| `<C-l>` | Refresh |
| `_` | Open cwd |
| `` ` `` | cd to directory |
| `~` | cd to directory (tab scope) |
| `gs` | Change sort |
| `gx` | Open external |
| `g.` | Toggle hidden files |
| `g\` | Toggle trash |
| `g?` | Show help |

## 5. Neovim Harpoon

*Source: `lua/plugins/harpoon.lua`*

| Key | Action |
| :--- | :--- |
| `<leader>m` | Add current file to Harpoon list |
| `<leader>M` | Toggle Harpoon quick menu |
| `<leader>1` | Jump to Harpoon file 1 |
| `<leader>2` | Jump to Harpoon file 2 |
| `<leader>3` | Jump to Harpoon file 3 |
| `<leader>4` | Jump to Harpoon file 4 |
| `<leader>p` | Previous Harpoon file |
| `<leader>n` | Next Harpoon file |

## 6. Neovim LSP

*Source: `lua/plugins/lsp.lua` (active when LSP is attached)*

| Key | Action |
| :--- | :--- |
| `gd` | Go to definition (Telescope) |
| `gr` | Go to references (Telescope) |
| `gI` | Go to implementation (Telescope) |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition (Telescope) |
| `<leader>ds` | Document symbols (Telescope) |
| `<leader>ws` | Workspace symbols (Telescope) |
| `<leader>wa` | Add workspace folder |
| `<leader>wr` | Remove workspace folder |
| `<leader>wl` | List workspace folders |
| `<leader>th` | Toggle inlay hints |

## 7. Neovim Git

### LazyGit

*Source: `lua/plugins/lazygit.lua`*

| Key | Action |
| :--- | :--- |
| `<leader>lg` | Open LazyGit |

### Gitsigns

*Source: `lua/plugins/gitsigns.lua` (default keymaps from gitsigns)*

Gitsigns uses its default keybindings. The plugin provides git hunk signs in the gutter (`+` added, `~` changed, `_` deleted).

## 8. Neovim Debugging

*Source: `lua/plugins/debug.lua`*

| Key | Action |
| :--- | :--- |
| `<F5>` | Start / Continue debugging |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |

**Supported debuggers:** debugpy (Python), codelldb (Rust/C/C++)

## 9. Neovim Code Navigation

### Aerial (Code Outline)

*Source: `lua/plugins/aerial.lua`*

| Key | Action |
| :--- | :--- |
| `<leader>o` | Toggle code outline sidebar |
| `<leader>on` | Toggle aerial nav (floating) |
| `{` | Jump to previous symbol |
| `}` | Jump to next symbol |

### Treesitter Text Objects

*Source: `lua/plugins/treesitter.lua`*

**Selection (visual mode):**

| Key | Action |
| :--- | :--- |
| `af` | Select around function |
| `if` | Select inside function |
| `ac` | Select around class |
| `ic` | Select inside class |
| `aa` | Select around parameter |
| `ia` | Select inside parameter |

**Motions:**

| Key | Action |
| :--- | :--- |
| `]m` | Next function start |
| `]M` | Next function end |
| `]]` | Next class start |
| `][` | Next class end |
| `[m` | Previous function start |
| `[M` | Previous function end |
| `[[` | Previous class start |
| `[]` | Previous class end |

**Swap:**

| Key | Action |
| :--- | :--- |
| `<leader>a` | Swap parameter with next |
| `<leader>A` | Swap parameter with previous |

**Incremental Selection:**

| Key | Action |
| :--- | :--- |
| `<C-Space>` | Init / expand selection |
| `<C-s>` | Expand to scope |
| `<M-Space>` | Shrink selection |

## 10. Neovim Editing

### Comment

*Source: `lua/plugins/comment.lua`*

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<C-/>` | Normal | Toggle comment on current line |
| `<C-c>` | Normal | Toggle comment on current line |
| `<C-/>` | Visual | Toggle comment on selection |
| `<C-c>` | Visual | Toggle comment on selection |

### Autocompletion

*Source: `lua/plugins/autocompletion.lua`*

| Key | Action |
| :--- | :--- |
| `<Tab>` | Select next completion / expand snippet |
| `<S-Tab>` | Select previous completion |
| `<C-j>` | Select next completion |
| `<C-k>` | Select previous completion |
| `<CR>` | Confirm completion |
| `<C-c>` | Trigger completion manually |
| `<C-l>` | Jump to next snippet placeholder |
| `<C-h>` | Jump to previous snippet placeholder |

## 11. Tmux Essentials

*Source: `tmux/tmux.conf`. Prefix: `Ctrl+Space`*

### Window Management

| Key | Action |
| :--- | :--- |
| `<Pre> c` | New window (in current path) |
| `<Pre> ,` | Rename window |
| `<Pre> &` | Kill window |
| `<Pre> n` | Next window |
| `<Pre> p` | Previous window |
| `<Pre> [1-9]` | Select window by number |

### Pane Management

| Key | Action |
| :--- | :--- |
| `<Pre> \` | Split horizontal (in current path) |
| `<Pre> -` | Split vertical (in current path) |
| `<Pre> m` | Maximize / zoom pane |
| `<Pre> x` | Kill pane |
| `<Pre> h` | Resize pane left (5 units) |
| `<Pre> j` | Resize pane down (5 units) |
| `<Pre> k` | Resize pane up (5 units) |
| `<Pre> l` | Resize pane right (5 units) |

### Copy Mode

1. `<Pre> [` — Enter copy mode
2. `v` — Begin visual selection
3. `y` — Copy to system clipboard (pbcopy)
4. `<Pre> P` — Paste inside tmux (or `Cmd+V` system-wide)

### Other

| Key | Action |
| :--- | :--- |
| `<Pre> r` | Reload tmux config |
| `<Pre> I` | Install TPM plugins |

## 12. Zsh / Shell

*Source: `zsh/custom.zsh`*

### Vi-Mode

| Key | Mode | Action |
| :--- | :--- | :--- |
| `Esc` | Insert | Switch to normal mode (block cursor) |
| `i` / `a` / etc. | Normal | Switch to insert mode (beam cursor) |
| `y` | Normal (vicmd) | Yank to system clipboard |
| `v` | Normal (vicmd) | Edit current command in Neovim |

### FZF

| Key / Command | Action |
| :--- | :--- |
| `Ctrl+T` | FZF file search (with bat preview) |
| `Ctrl+R` | FZF command history search |
| `Alt+C` (or `ç`) | FZF cd to directory |
| `fd` | Interactive cd to subdirectory via fzf |
| `fh` | Search and execute from command history |

### Zoxide

| Key / Command | Action |
| :--- | :--- |
| `z <query>` | Jump to frequently visited directory |
| `zi <query>` | Interactive directory selection via fzf |

## 13. WezTerm

*Source: `wezterm/config.lua`*

| Key | Action |
| :--- | :--- |
| `Ctrl+Enter` | Send `\x1b[13;5u` (for Neovim mappings) |
| `Shift+Enter` | Send `\x1b[13;2u` (for Neovim mappings) |

## Notes

**`<leader>w`:** Maps to Neo-tree Float File Explorer (defined in `neo-tree.lua`). It is **not** a save shortcut — use `<C-s>` to save files.
