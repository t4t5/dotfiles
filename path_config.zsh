# Utility for concatenating a directory to the PATH:
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# System default:
PATH="$HOME/bin:/usr/bin:/bin"

# Personalized scripts:
pathadd "$HOME/.bin"

# fig, lvim, scarb...
pathadd "$HOME/.local/bin"

# homebrew:
export BREW_ROOT="/opt/homebrew"
pathadd "$BREW_ROOT/bin"
pathadd "$BREW_ROOT/sbin"

# rbenv:
export RBENV_ROOT="$BREW_ROOT/opt/rbenv"
pathadd "$RBENV_ROOT/bin"

# postgres:
pathadd "$BREW_ROOT/opt/postgresql@15/bin"

# rust:
pathadd "$HOME/.cargo/bin"

# Solana CLI:
pathadd "$HOME/.local/share/solana/install/active_release/bin"

# Anchor (Solana)
pathadd "$HOME/.avm/bin"

# OpenSSL:
pathadd "$BREW_ROOT/opt/openssl@1.1/bin"

# Elasticsearch:
pathadd "/usr/local/opt/elasticsearch@5.6/bin"

# Volta:
export VOLTA_HOME="$HOME/.volta"
pathadd "$VOLTA_HOME/bin"

# Starklings
pathadd "$HOME/.starklings/dist/starklings"

# Foundry
pathadd "$HOME/.foundry/bin"

# Noir
pathadd "$HOME/.nargo/bin"

# Fuel
pathadd "$HOME/.fuelup/bin"

# for gui elements:
pathadd "$HOME/usr/local/opt/tcl-tk/bin"

# use homebrew version of java:
pathadd "$BREW_ROOT/opt/openjdk/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
pathadd "$BUN_INSTALL/bin"

# FINAL EXPORT:
export PATH
