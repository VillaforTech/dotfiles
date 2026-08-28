# Neovim architecture

Neovim remains the focused editor; Codex runs beside it rather than inside it.
The existing lazy.nvim lock transition and local live-preview experiment remain
preserved but outside this migration; they are not required by the portable v1
configuration until reviewed separately.
Oil and Telescope provide the primary lightweight navigation path, while
existing optional UI modules remain available until usage evidence supports a
separate cleanup.

No cwd file executes during startup. `:SessionSave` writes the exact
`.session.vim` in the current directory. `:SessionLoad` is explicit and passes
the file through Neovim's trust database before executing it. The associated
keys are `<leader>ss` and `<leader>sl`.

Terminal padding belongs to WezTerm; Neovim runs no Kitty remote-control
commands. Cross-pane navigation belongs to vim-tmux-navigator, and Treesitter
selection uses `<leader>is`, `<leader>in`, `<leader>ic`, and `<leader>id`.

Formatting and lint plugin specs remain dormant until their binaries and plugin
packages are intentionally installed and tested; documentation does not claim
they are active.
