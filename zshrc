# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

alias ..="cd .."

# ZSH
export ZSH=/Users/tristan/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
plugins=(git git-extras npm)
source $ZSH/oh-my-zsh.sh

# Ruby
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"

# Postgres
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# NVM
unset npm_config_prefix
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

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

# Java version:
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home"

# For Go:
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# added by travis gem
[ -f /Users/tristan/.travis/travis.sh ] && source /Users/tristan/.travis/travis.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rbenv
eval "$(rbenv init -)"
