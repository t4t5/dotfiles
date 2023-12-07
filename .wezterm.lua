-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- User settings:
config.color_scheme = 'tokyonight_moon'
config.enable_tab_bar = false
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 13
config.window_padding = {
  top = 55,
  bottom = 0,
  left = 10,
  right = 10,
}
-- Make option-{x} work as expected:
config.send_composed_key_when_left_alt_is_pressed = true
config.disable_default_key_bindings = true

local act = wezterm.action

config.keys = {
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "v", mods = "CMD",  action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "CMD",  action = act.CopyTo("Clipboard") },
}

-- and finally, return the configuration to wezterm
return config
