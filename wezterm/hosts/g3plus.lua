local wezterm = require 'wezterm'

local function apply(config)
  config.font = wezterm.font "CodeNewRoman Nerd Font"
  config.font_size = 13

  return config
end

return {
  apply = apply,
}
