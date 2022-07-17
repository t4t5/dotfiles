# Uncomment this and the bottom line to see what's taking time to load:
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH
export ZSH=/Users/tristan/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
source $ZSH/oh-my-zsh.sh
ZSH_DISABLE_COMPFIX="true"

source $(brew --prefix)/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='ag --nocolor -g ""'

# Make autosuggestions visible
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#757575"

# Homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
alias brew='arch -arm64 brew'

# Ruby
export RBENV_ROOT=/opt/homebrew/opt/rbenv
export PATH=$RBENV_ROOT/bin:$PATH
alias gem='arch -arm64 gem'
alias bundle='arch -arm64 bundle'

# Rbenv
eval "$(arch -arm64 rbenv init - zsh)"

rbenv() {
  arch -arm64 rbenv "$@"
}

# Postgres
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

# ngircd
export PATH="/usr/local/sbin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Anchor (Solana)
export PATH="$HOME/.avm/bin:$PATH"

# OpenSSL
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"

# Git commands:
source ~/.zshrc_git_aliases

alias s="source ~/.zshrc;tmux source-file ~/.tmux.conf;source ~/.zprofile"

alias boom="~/dev/projects/boom/target/debug/boom"

alias pythonserver="python -m SimpleHTTPServer 8000"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

alias f='cd && cd "$(fd --type d | fzf)"'

# Go to the "experiments" folder
alias exp='cd ~/dev/projects/experiments'

killport() {
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill;
}

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
export GOROOT="/opt/homebrew/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ElasticSearch
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"

# Uncomment this and the first line in this file to see what's slow:
# zprof
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Solana
export PATH="/Users/tristan/.local/share/solana/install/active_release/bin:$PATH"

export PATH="$PATH:/Users/tristan/.starklings/dist/starklings"
