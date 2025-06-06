local wezterm = require 'wezterm'
local keymap = require 'keymap'

local config = wezterm.config_builder()

config.font = wezterm.font 'CodeNewRoman Nerd Font Mono'
config.font_size = 14

config.keys = keymap.keys
config.key_tables = keymap.key_tables
config.mouse_bindings = keymap.mouse_bindings
config.disable_default_key_bindings = true

config.hide_tab_bar_if_only_one_tab = true

config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'
-- nightly only :(
-- config.show_close_tab_button_in_tabs = false

return config
