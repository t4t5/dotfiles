## Overview

Personal dotfiles for Omarchy (Arch Linux + Hyprland). Core tools: kitty, neovim, tmux.

## Setup on new machine

```bash
# 1. Symlink all configs
./install

# 2. Run setup scripts
./setup/locale.sh    # System locale
./setup/omarchy.sh   # Arch packages and Omarchy-specific setup
./setup/volta.sh     # Node.js version manager

# macOS only
./setup/brew.sh      
```

## Structure

- **dotbot.conf.yaml**: Defines all symlinks (platform-conditional with `if: '[ "$(uname)" = "Linux" ]'`)
- **config/**: App configs → `~/.config/` (nvim, hypr, waybar, kitty, yazi, etc.)
- **bin/**: Custom scripts → `~/.bin/` (includes `g` for fzf-powered git)
- **setup/**: One-time installation scripts
