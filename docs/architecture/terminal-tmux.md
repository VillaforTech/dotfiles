# Terminal and tmux architecture

WezTerm always starts `/bin/zsh -l`. This recovery boundary remains usable if
tmux or a project configuration fails. Named project sessions begin with
`work <alias>` rather than an anonymous automatic attachment.

Tmux owns `Ctrl+Space`; Neovim owns `Space`. `Ctrl+h/j/k/l` crosses Neovim
splits and tmux panes through vim-tmux-navigator. Treesitter incremental
selection uses the `<leader>i*` namespace and does not compete for the prefix.

TPM has one active location: `~/.config/tmux/plugins/tpm`. Resurrect keeps
visible pane content for continuity, limits layout snapshots to 14 days, and
runs `tmux-secure-resurrect` after each save so directories are `0700` and files
are `0600`. Prefix + `S` temporarily disables pane-content capture for sensitive
work while layout/process metadata continues to save.

Configuration validation always uses a named isolated socket. It may kill only
that test socket, never the user's default server.
