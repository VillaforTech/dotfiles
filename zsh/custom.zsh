# Homebrew behavior (PATH initialization belongs to .zprofile)
export HOMEBREW_NO_AUTO_UPDATE=1

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# Load Git completion
zstyle ':completion:*:*:git:*' script "$HOME/.config/zsh/git-completion.bash"
fpath=("$HOME/.config/zsh" $fpath)
autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# uv completion requires compinit/compdef to exist first.
if (( $+commands[uv] )); then
  eval "$(uv generate-shell-completion zsh)"
fi

# Redshift
export ODBCINI="$HOME/.odbc.ini"
export ODBCSYSINI="/opt/amazon/redshift/Setup"
export AMAZONREDSHIFTODBCINI="/opt/amazon/redshift/lib/amazon.redshiftodbc.ini"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/lib"

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

if (( $+commands[bat] )); then
  export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
else
  export FZF_CTRL_T_OPTS="--preview 'sed -n 1,200p {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

bindkey "ç" fzf-cd-widget # Fix for ALT+C on Mac

# cdf - cd to a selected directory without shadowing the fd executable
cdf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git . "${1:-.}" | fzf +m) &&
  cd "$dir"
}

# fh - search command history and put the selection on the edit buffer
fh() {
  local selected
  selected=$(fc -rl 1 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' | fzf +s) || return
  print -z -- "$selected"
}

# Tmux
# Always work in a tmux session if Tmux is installed
# if which tmux >/dev/null 2>&1; then
#   # Check if the current environment is suitable for tmux
#   if [[ -z "$TMUX" && \
#         $TERM != "screen-256color" && \
#         $TERM != "screen" && \
#         -z "$VSCODE_INJECTION" && \
#         -z "$INSIDE_EMACS" && \
#         -z "$EMACS" && \
#         -z "$VIM" && \
#         -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
#     # Try to attach to the default tmux session, or create a new one if it doesn't exist
#     tmux attach -t default >/dev/null 2>&1 || tmux new -s default
#     exit
#   fi
# fi

# zoxide - a better cd command
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Project-scoped environment loading. Each project still requires its one-time
# direnv allow decision.
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# Activate syntax highlighting
[[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
# Change colors
# export ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Activate autosuggestions
[[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Clickup
# Vi mode
# ANSI cursor escape codes:
# \e[0 q: Reset to the default cursor style.
# \e[1 q: Blinking block cursor.
# \e[2 q: Steady block cursor (non-blinking).
# \e[3 q: Blinking underline cursor.
# \e[4 q: Steady underline cursor (non-blinking).
# \e[5 q: Blinking bar cursor.
# \e[6 q: Steady bar cursor (non-blinking).
bindkey -v # Enable vi keybindings
export KEYTIMEOUT=1 # Makes switching modes quicker
export VI_MODE_SET_CURSOR=true # trigger cursor shape changes when switching modes

# Gets called every time the keymap changes (insert <-> normal mode)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q' # block
  else
    echo -ne '\e[6 q' # beam
  fi
}
# Register this function as a ZLE (Zsh Line Editor) widget
zle -N zle-keymap-select

# Runs once when a new ZLE session starts (e.g. when a prompt appears)
zle-line-init() {
  zle -K viins # initiate 'vi insert' as keymap (can be removed if 'binkey -V has been set elsewhere')
  echo -ne '\e[6 q'
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup

# Yank to the system clipboard
function vi-yank-clipboard {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard

# Press 'v' in normal mode to launch Vim with current line
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Create a Python venv with uv and register a Jupyter kernel
mkpy() {
  local pyv="${1:-3.12}"
  local proj="${2:-$(basename $PWD)}"

  uv venv --python "$pyv"
  source .venv/bin/activate

  uv pip install ipykernel ruff
  python -m ipykernel install --user --name="$proj" --display-name="$proj (Python $pyv)"

  echo "Environment ready: Python $pyv, kernel '$proj' registered"
}

# Scaffold a data science project with uv
mkds() {
  local pyv="${1:-3.12}"
  local proj="${2:-$(basename $PWD)}"

  mkdir -p notebooks src data/{raw,interim,processed} reports tests
  mkpy "$pyv" "$proj"
  uv pip install jupyterlab pandas numpy matplotlib

  git init -q
  if [[ ! -e .gitignore ]]; then
    printf '%s\n' .venv/ __pycache__/ '*.pyc' data/raw/ data/interim/ .ipynb_checkpoints/ > .gitignore
  fi

  echo "Data science project '$proj' ready; review files before the first commit"
}
