# Uncomment this and the bottom line to see what's taking time to load:
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH
export ZSH=/Users/tristan/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/antigen/antigen.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='ag --nocolor -g ""'

# Ruby
export PATH="$HOME/.rbenv/shims:/usr/local/bin:$PATH"

# Postgres
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

# ngircd
export PATH="/usr/local/sbin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# OpenSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# Git commands:
source ~/.zshrc_git_aliases

alias s="source ~/.zshrc"

alias boom="~/dev/projects/boom-cli/target/debug/boom"

alias pythonserver="python -m SimpleHTTPServer 8000"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

alias f='cd && cd "$(fd --type d | fzf)"'

v() {
  if [ $# -gt 0 ]; then
    nvim "$@"
  else
    nvim .
  fi
}

hound() {
  sass-lint -c .sass-lint.yml "$@" -v -q
}

addhusky() {
  npm install -D husky
  npm set-script prepare "husky install"
  npm run prepare
  npx husky add .husky/pre-commit "npm run format"
}

alias r=". ranger"
alias gg="gitui"

mcd() {
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# Use tmux by default when using terminal
if [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Make sure Vim colors work in tmux:
export TERM="xterm-256color-italic"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
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


# ElasticSearch
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Uncomment this and the first line in this file to see what's slow:
# zprof
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Solana
export PATH="/Users/tristan/.local/share/solana/install/active_release/bin:$PATH"
