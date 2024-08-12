-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Hide the titlebar
config.window_decorations = "RESIZE"

-- Enable background blur
config.macos_window_background_blur = 20

-- Enable background transparency
config.window_background_opacity = 0.8
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
config.default_cursor_style = "SteadyBar"

-- Disable the tab bar
config.enable_tab_bar = false

-- Set font and font size
config.font = wezterm.font("MesloLGM Nerd Font")
config.font_size = 11.0

-- Set a custom color scheme (optional, you can choose another scheme or remove this line)
config.color_scheme = "Catppuccin mocha"

-- Additional customization: Set a custom background color if desired
config.colors = {
	background = "#1e1e2e",
	cursor_bg = "#FFFFFF", -- Cursor color
	cursor_fg = "#000000", -- Text color under the cursor
	cursor_border = "#FFFFFF",
}

-- Returns the config
return config
