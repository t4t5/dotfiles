# Uncomment this and the bottom line to see what's taking time to load:
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH
export ZSH=/Users/tristan/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
source $ZSH/oh-my-zsh.sh

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='ag --nocolor -g ""'

# Ruby
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"

# Postgres
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Git commands:
source ~/.zshrc_git_aliases

alias r="source ~/.zshrc"

v() {
  if [ $# -gt 0 ]; then
    vim "$@"
  else
    vim .
  fi
}

# Use tmux by default when using terminal
if [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Make sure Vim colors work in tmux:
export TERM="xterm-256color"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# For Go:
export GOPATH="${HOME}/.go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Rbenv
rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NOTION_HOME="$HOME/.notion"
[ -s "$NOTION_HOME/load.sh" ] && \. "$NOTION_HOME/load.sh"

export PATH="${NOTION_HOME}/bin:$PATH"

# Uncomment this and the first line in this file to see what's slow:
# zprof
