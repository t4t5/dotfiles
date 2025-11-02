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
  yazi \
  just \
  wget \
  go \
  fzf

echo "Core packages installed successfully!"

# Set shell to zsh:
current_shell=$(basename "$SHELL")

if [ "$current_shell" != "zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  chsh -s $(which zsh)
fi

# Install desktop apps:
yay -S chatwise
yay -S slack-desktop
yay -S notion-app-electron
yay -S volta # for nodejs
yay -S tableplus
yay -S nordvpn-bin
yay -S nordvpn-gui

echo "Desktop apps installed successfully!"
