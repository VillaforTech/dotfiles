# System
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='pmset sleepnow'
alias sleep='pmset sleepnow'
alias c='clear'
alias e='exit'

alias cc='claude'
alias cx='codex'
alias cxr='codex --sandbox read-only --ask-for-approval never'
alias cxo='codex --sandbox danger-full-access --ask-for-approval on-request'
alias gmc='gemini --sandbox'

# Git
alias g='git'
alias ga='git add'
alias gafzf='git ls-files -m -o --exclude-standard | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add' # Git add with fzf
alias grmfzf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git rm' # Git rm with fzf
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore' # Git restore with fzf
alias grsfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged' # Git restore --staged with fzf
alias gf='git fetch'
alias gs='git status'
alias gss='git status -s'
alias gup='git pull --ff-only'
alias gtd='git tag --delete'
alias gtdr='git push origin --delete'
alias glo='git pull --ff-only origin'
alias gl='git pull --ff-only'
alias gb='git branch '
alias gbr='git branch -r'
alias gd='git diff'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gcofzf='git branch | fzf | xargs git checkout' # Select branch with fzf
alias gre='git remote'
alias gres='git remote show'
alias glgg='git log --graph --max-count=5 --decorate --pretty="oneline"'
alias gm='git merge'
alias gp='git push'
alias gpo='git push origin'
alias ggpush='git push origin $(current_branch)'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcmnv='git commit -m'
alias gcanenv='git commit --amend --no-edit'
# Function to commit with ticket ID from current branch, with optional push
quick_commit() {
  local branch_name ticket_id commit_message push_flag
  branch_name=$(git branch --show-current)
  ticket_id=$(echo "$branch_name" | awk -F '-' '{print toupper($1"-"$2)}')
  commit_message="$ticket_id: $*"
  push_flag=$1

  if [[ "$push_flag" == "push" ]]; then
    # Remove 'push' from the commit message
    commit_message="$ticket_id: ${*:2}" # take all positional parameters starting from the second one
    git commit -m "$commit_message" && git push
  else
    git commit -m "$commit_message"
  fi
}

alias gqc='quick_commit'
alias gqcp='quick_commit push'

# Neovim
alias vi='nvim'
alias v='nvim'

# Folders
alias doc="$HOME/Documents"
alias dow="$HOME/Downloads"

# Ranger
alias r="ranger"

# Better ls
alias ls="eza --all --icons=always"

# Lazygit
alias lg="lazygit"

alias lv="cd .."
alias lv2="cd ../.."
alias lv3="cd ../../.."
alias lv4="cd ../../../.."
