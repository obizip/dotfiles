local wezterm = require 'wezterm'
local keymap = require 'keymap'
local host_config = require 'host_config'

local config = wezterm.config_builder()

config.font_size = 15

config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = keymap.keys
config.key_tables = keymap.key_tables
config.mouse_bindings = keymap.mouse_bindings

config.colors = {
  foreground = '#EEEEEE',
  background = '#2d2530',
  brights = {
    'grey',
    'red',
    'lime',
    'yellow',
    'dodgerblue',
    'fuchsia',
    'aqua',
    'white',
  },
}

config = host_config.apply(config)

return config
