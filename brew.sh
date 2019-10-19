#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew install volta
brew install tmux
brew install rbenv
brew install ack
brew install the_silver_searcher
brew install macvim --with-override-system-vim
brew install imagemagick --with-webp

brew install puma/puma/puma-dev
sudo puma-dev -setup
puma-dev -install

# Start Redis on start
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

brew install fzf
$(brew --prefix)/opt/fzf/install

# Remove outdated versions from the cellar.
brew cleanup
