#!/usr/bin/env bash

set -e

# Update package database
sudo pacman -Sy

# Install core packages
sudo pacman -S --needed --noconfirm \
  neovim \
  tmux \
  ripgrep \
  ack \
  hub \
  imagemagick \
  postgresql \
  git-delta \
  fzf

echo "Package installation complete!"
