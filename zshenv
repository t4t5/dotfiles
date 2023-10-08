# Reload zsh + tmux config:
alias s="reload"

# use "just server" instead?
alias pythonserver="python3 -m http.server 8000"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

# Go to the "experiments" folder
alias exp='cd ~/dev/projects/experiments'

# git UI
alias gg="gitui"

# Python
alias python='python3'
alias pip='pip3'

# Postgres CLI
alias pg=pgcli

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
