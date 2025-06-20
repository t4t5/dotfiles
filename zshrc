# ---- START
# Uncomment next line + last line of file
# to see what's taking time to load:
#
# zmodload zsh/zprof

source $HOME/aliases.zsh
source $HOME/path_config.zsh

# ZSH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
ZSH_DISABLE_COMPFIX="true"
# Make autosuggestions visible
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#757575"
source $ZSH/oh-my-zsh.sh

# Theme for cat alternative (bat):
export BAT_THEME="OneHalfDark"

# Load antigen plugins:
source $HOME/antigen.zsh
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# Claude Code
alias claude="/Users/tristan/.claude/local/claude"

# Homebrew
alias brew='arch -arm64 brew'
# Prevent brew from upgrading everything every time:
HOMEBREW_NO_AUTO_UPDATE=1

# Ruby
alias gem='arch -arm64 gem'
alias bundle='arch -arm64 bundle'
rbenv() {
  arch -arm64 rbenv "$@"
}

# OpenSSL
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"

# Use tmux by default when using terminal
if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  tmux attach -t default || tmux new -s default
fi

# Make sure Vim colors work in tmux:
# export TERM="xterm-256color-italic"
export TERM=xterm-256color

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
pathadd "${GOPATH}/bin"
pathadd "${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='ag --nocolor -g ""'

alias f='cd && cd "$(fd --type d | fzf)"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# for GPG sign of commits:
export GPG_TTY=$(tty)

# -- Use pyenv for python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Generated by Hermit; START; DO NOT EDIT.
HERMIT_ROOT_BIN="${HERMIT_ROOT_BIN:-"$HOME/bin/hermit"}"
eval "$(test -x $HERMIT_ROOT_BIN && $HERMIT_ROOT_BIN shell-hooks --print --zsh)"
# Generated by Hermit; END; DO NOT EDIT.

# ------ END
# Uncomment next line + first line of file to see what's slow:
# zmodload zsh/zprof
