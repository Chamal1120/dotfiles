-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_wayland = true
-- Hide the titlebar
-- config.window_decorations = "RESIZE"

-- Enable background blur
-- config.macos_window_background_blur = 20

-- Enable background transparency
config.window_background_opacity = 0.95
config.text_background_opacity = 1

-- Add padding to the window
config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

-- Remove exit confirmation
config.window_close_confirmation = "NeverPrompt"

-- Set custom cursor style
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- Disable the tab bar
config.enable_tab_bar = false

-- Set font and font size
config.font = wezterm.font("MesloLGM Nerd Font")
config.font_size = 11.0

-- Set a custom color scheme (optional, you can choose another scheme or remove this line)
-- config.color_scheme = 'Catppuccin mocha'

config.colors = {
  -- The default text color
  foreground = '#cdd6f4',
  -- The default background color
  background = '#1e1e2e',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#cdd6f4',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#1e1e2e',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#cdd6f4',

  -- the foreground color of selected text
  selection_fg = '#f5e0dc',
  -- the background color of selected text
  selection_bg = '#45475a',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',

  ansi = {
    '#45475a', -- Black
    '#f38ba8', -- Red
    '#a6e3a1', -- Green
    '#f9e2af', -- Yellow
    '#89b4fa', -- Blue
    '#f5c2e7', -- Magenta
    '#94e2d5', -- Cyan
    '#bac2de', -- White
  },
  brights = {
    '#585b70', -- Bright Black
    '#f38ba8', -- Bright Red
    '#a6e3a1', -- Bright Green
    '#f9e2af', -- Bright Yellow
    '#89b4fa', -- Bright Blue
    '#f5c2e7', -- Bright Magenta
    '#94e2d5', -- Bright Cyan
    '#a6adc8', -- Bright White
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = '#af8700' },

  -- Compose cursor color
  compose_cursor = '#fab387',

  -- Colors for copy_mode and quick_select
  copy_mode_active_highlight_bg = { Color = '#1e1e2e' },
  copy_mode_active_highlight_fg = { AnsiColor = 'Silver' },
  copy_mode_inactive_highlight_bg = { Color = '#45475a' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = '#f5c2e7' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = '#ffffff' },
}

-- Additional customization: Set a custom background color if desired
-- config.colors = {
--   background = "#1e1e2e",
--   cursor_bg = "#FFFFFF", -- Cursor color
--   cursor_fg = "#000000", -- Text color under the cursor
--   cursor_border = "#FFFFFF",
-- }

-- Returns the config
return config
