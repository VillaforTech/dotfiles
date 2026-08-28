# zsh Options
setopt HIST_IGNORE_ALL_DUPS
typeset -U path PATH

# Interactive preferences stay out of .zshenv so scripts and GUI processes do
# not pay prompt/completion startup costs.
export EDITOR="nvim"
export VISUAL="nvim"
export TMUX_THEME="nord"
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"

# Custom zsh
[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"

# Aliases
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"


# OpenClaw's launchd-managed gateway remains available. Its generated 137 KB
# completion is deliberately not sourced by every interactive shell.
