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

## GTK4 Theming

GTK4 apps (Nautilus, zenity, etc.) are styled via `config/gtk-4.0/`:

- **style.css**: Base Adwaita color overrides (semantic colors like `sidebar_bg_color`, `accent_color`, etc.)
- **gtk.css**: Theme-specific colors that `style.css` references (`@background`, `@foreground`, `@blue`, etc.)

To change themes, update the color variables in `gtk.css`. Format matches Omarchy theme colors.

## Notes

Not all Hyprland/Walker/Omarchy settings are specified here. Some are in `~/.local/share/omarchy`
