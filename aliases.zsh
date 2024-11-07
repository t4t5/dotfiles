# Reload zsh + tmux config:
alias s="reload"

# Needs alias in order to overwrite built-in "r" command:
alias r='joshuto --output-file /tmp/joshutodir; LASTDIR=`cat /tmp/joshutodir`; cd "$LASTDIR"'

alias ai="ollama run llama3"

# use "just server" instead?
alias pythonserver="python3 -m http.server 8000"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

alias rust="evcxr"

# Go to the "experiments" folder
alias exp='cd ~/dev/projects/experiments'

alias ord='~/dev/projects/ordinals/ord-api/target/debug/ord'

alias ls='eza -a'

# git UI
alias gg="gitui"

v() {
  # hermit messes up rust-analyzer sometimes. Don't use it in neovim:
  if [ -n "$HERMIT_ENV" ] && command -v deactivate-hermit > /dev/null 2>&1; then
    deactivate-hermit
  fi

  if [ $# -gt 0 ]; then
    nvim "$@"
  else
    nvim
  fi
}

ports() {
  lsof -iTCP -sTCP:LISTEN -n -P | awk 'NR>1 {print $9, $1, $2}' | sed 's/.*://' | while read port process pid; do echo "Port $port: $(ps -p $pid -o command= | sed 's/^-//') (PID: $pid)"; done | sort -n
}

# Python
# alias python='python3'
# alias pip='pip3'

# Postgres CLI
alias pg='pgcli postgres'

# Used in create/add scripts:
set_github_secret_from_op() {
  key=$1
  op_secret_ref=$2

  export $key="$op_secret_ref"
  value="$(op run --no-masking -- printenv $key)"

  gh secret set $key --body $value
}

set_github_variable_from_op() {
  key="TMP_$1"
  op_secret_ref=$2

  export $key="$op_secret_ref"
  value="$(op run --no-masking -- printenv $key)"

  gh variable set $key --body $value
}
