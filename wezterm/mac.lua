local wezterm = require 'wezterm'

local function apply(config)
  config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'

  -- config.font = wezterm.font 'Explex35 Console NF'
  config.font = wezterm.font 'UDEV Gothic 35NF'
  config.font_size = 15

  return config
end

return {
  apply = apply,
}
