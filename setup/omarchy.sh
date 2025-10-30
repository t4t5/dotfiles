#!/usr/bin/env bash

set -e

# Update package database
sudo pacman -Sy

# Install core packages
sudo pacman -S --needed --noconfirm \
  zsh \
  pyenv \
  neovim \
  tmux \
  ripgrep \
  hub \
  imagemagick \
  postgresql \
  git-delta \
  fzf

current_shell=$(basename "$SHELL")

if [ "$current_shell" != "zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  chsh -s $(which zsh)
fi

echo "Package installation complete!"
