local wezterm = require("wezterm")
local keymap = require("keymap")
local host_config = require("host_config")

local config = wezterm.config_builder()

config.font_size = 15

config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = keymap.keys
config.key_tables = keymap.key_tables
config.mouse_bindings = keymap.mouse_bindings

config.colors = {
	ansi = {
		"#000000",
		"#cc5555",
		"#55cc55",
		"#cdcd55",
		"#5555cc",
		"#cc55cc",
		"#7acaca",
		"#cccccc",
	},
	brights = {
		"#555555",
		"#ff5555",
		"#55ff55",
		"#ffff55",
		"#5555ff",
		"#ff55ff",
		"#55ffff",
		"#ffffff",
	},
	cursor_bg = "#53ae71",
	cursor_border = "#53ae71",
	cursor_fg = "#000000",
	foreground = "#cecece",
	background = "#0e1415",
	indexed = {},
}

config = host_config.apply(config)

return config
