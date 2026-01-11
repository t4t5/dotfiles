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
  tree \
  imagemagick \
  postgresql \
  git-delta \
  yazi \
  just \
  wget \
  go \
  netcat \
  lsof \
  pavucontrol \
  python-pip \
  ansible-core \
  fzf

# Create tmux config directory if it doesn't exist
mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
yay -S emote # emojis
yay -S xdg-desktop-portal-termfilechooser-hunkyburrito-git # use yazi as default file selector

# maildir:
yay -S mbsync
yay -S aerc
yay -S mu

# drag and drop files from yazi:
yay -S ripdrag

echo "Desktop apps installed successfully!"
