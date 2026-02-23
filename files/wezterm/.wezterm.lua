local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { 'powershell.exe' }

config.initial_cols = 120
config.initial_rows = 32

config.font_size = 12

config.color_scheme = 'Breeze'

-- config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"

config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = 0,
  bottom = 0,
}

return config
