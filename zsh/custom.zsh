# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1

# uv (Python package manager)
eval "$(uv generate-shell-completion zsh)"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
starship config palette $STARSHIP_THEME

# Load Git completion
zstyle ':completion:*:*:git:*' script $HOME/.config/zsh/git-completion.bash
fpath=($HOME/.config/zsh $fpath)
autoload -Uz compinit && compinit

# Redshift
export ODBCINI="$HOME/.odbc.ini"
export ODBCSYSINI="/opt/amazon/redshift/Setup"
export AMAZONREDSHIFTODBCINI="/opt/amazon/redshift/lib/amazon.redshiftodbc.ini"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/lib"

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND='rg --hidden -l ""' # Include hidden files

bindkey "ç" fzf-cd-widget # Fix for ALT+C on Mac

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
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
eval "$(zoxide init zsh)"

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
# Change colors
# export ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

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
  echo -e ".venv/\n__pycache__/\n*.pyc\ndata/raw/\ndata/interim/\n.ipynb_checkpoints/" > .gitignore
  git add . && git commit -m "Initial commit: project skeleton with Python $pyv" >/dev/null

  echo "Data science project '$proj' ready"
}
