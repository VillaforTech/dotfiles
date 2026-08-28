# Login-shell tool discovery. Keep interactive features in .zshrc.
typeset -U path PATH

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  /opt/homebrew/opt/postgresql@18/bin
  /usr/local/bin
  $path
)

export PATH
