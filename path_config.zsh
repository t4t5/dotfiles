# Utility for concatenating a directory to the PATH:
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# System default:
PATH="$HOME/bin:/usr/bin:/bin"
pathadd "/usr/sbin"

# Personalized scripts:
pathadd "$HOME/.bin"

# ollama, orb, docker...
pathadd "/usr/local/bin"

# fig, lvim, scarb...
pathadd "$HOME/.local/bin"

# bitcoin
pathadd "$HOME/opt/bitcoin-30.0/bin"

# rust:
pathadd "$HOME/.cargo/bin"

# Solana CLI:
pathadd "$HOME/.local/share/solana/install/active_release/bin"

# Omarchy commands:
pathadd "$HOME/.local/share/omarchy/bin"

# Anchor (Solana)
pathadd "$HOME/.avm/bin"

# Elasticsearch:
pathadd "/usr/local/opt/elasticsearch@5.6/bin"

# Volta:
export VOLTA_HOME="$HOME/.volta"
pathadd "$VOLTA_HOME/bin"

# Starklings
pathadd "$HOME/.starklings/dist/starklings"

# Opencode:
pathadd "$HOME/.opencode/bin"

# Foundry
pathadd "$HOME/.foundry/bin"

# Noir
pathadd "$HOME/.nargo/bin"

# Fuel
pathadd "$HOME/.fuelup/bin"

# for gui elements:
pathadd "$HOME/usr/local/opt/tcl-tk/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
pathadd "$BUN_INSTALL/bin"

# bb (noir lang)
pathadd "$HOME/.bb"

# Risc Zero
pathadd "$HOME/.risc0/bin"

# MacOS specific paths:
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Homebrew version of llvm/clang:
  pathadd "/usr/local/opt/llvm/bin"

  # homebrew:
  export BREW_ROOT="/opt/homebrew"
  pathadd "$BREW_ROOT/bin"
  pathadd "$BREW_ROOT/sbin"

  # postgres (brew version):
  pathadd "$BREW_ROOT/opt/postgresql@15/bin"

  # rbenv (bre version):
  export RBENV_ROOT="$BREW_ROOT/opt/rbenv"
  pathadd "$RBENV_ROOT/bin"

  # OpenSSL:
  pathadd "$BREW_ROOT/opt/openssl@1.1/bin"

  # use homebrew version of java:
  pathadd "$BREW_ROOT/opt/openjdk/bin"
fi

# FINAL EXPORT:
export PATH
