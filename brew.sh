#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew tap thoughtbot/formulae
brew install rcm
brew install python
brew install neovim
brew install volta
brew install tmux
brew install rbenv
eval "$(rbenv init -)"
brew install ripgrep
brew install ack
brew install zsh-autosuggestions
brew install hub
brew install imagemagick --with-webp
brew install watchman
brew install ngircd
brew install postgres
brew install go
brew install hugo
brew install httpie
brew install gnu-sed
brew install highlight
brew install bat
brew install fd
brew install gitui
brew install antigen

# For M1 macs, cocoapods need to be installed from Brew:
brew install cocoapods

brew tap mongodb/brew
brew install mongodb-community

brew install puma/puma/puma-dev
sudo puma-dev -setup
puma-dev -install

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
