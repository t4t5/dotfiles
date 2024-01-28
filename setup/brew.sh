#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew install python
brew install neovim
brew install volta
brew install tmux
brew install shared-mime-info
brew install libpq
brew install ripgrep
brew install ack
brew install hub
brew install imagemagick --with-webp
brew install watchman
brew install postgresql
brew install go
brew install hugo
brew install gnu-sed
brew install highlight
brew install bat
brew install fd
brew install gitui
brew install antigen
brew install rustup
brew install ngrok/ngrok/ngrok
brew install joshuto
brew install just
brew install 1password-cli
brew install jq

# Ruby stuff
brew tap thoughtbot/formulae
brew install rcm
brew install rbenv
eval "$(rbenv init -)"

# pgcli
brew tap dbcli/tap
brew install pgcli

# solc for Solidity
brew tap ethereum/ethereum
brew install solidity

# For M1 macs, cocoapods need to be installed from Brew:
brew install cocoapods

brew tap mongodb/brew
brew install mongodb-community

pip3 install ranger-fm pynvim
pip install github-clone

# Start Redis on start
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

brew install fzf
$(brew --prefix)/opt/fzf/install

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Remove outdated versions from the cellar.
brew cleanup
