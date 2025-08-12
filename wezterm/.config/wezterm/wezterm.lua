-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_schemes = config.color_schemes or {}

config.colors = {
	-- primary
	background = "#0d0e0f",
	foreground = "#d4be98",

	-- normal
	ansi = {
		"#665c54", -- black
		"#ea6962", -- red
		"#a9b665", -- green
		"#e78a4e", -- yellow
		"#7daea3", -- blue
		"#d3869b", -- magenta
		"#89b482", -- cyan
		"#d4be98", -- white
	},

	-- bright
	brights = {
		"#928374", -- black
		"#ea6962", -- red
		"#a9b665", -- green
		"#d8a657", -- yellow
		"#7daea3", -- blue
		"#d3869b", -- magenta
		"#89b482", -- cyan
		"#d4be98", -- white
	},

	-- indexed (optional extras)
	indexed = { [16] = "#e78a4e", [17] = "#d4be98" },

	-- cursors / selection
	cursor_bg = "#d4be98",
	cursor_fg = "#0d0e0f",
	cursor_border = "#d4be98",

	selection_bg = "#665c54",
	selection_fg = "#d4be98",

	-- minimal tab bar / UI entries (reasonable defaults)
	scrollbar_thumb = "#0f0f10",
	split = "#665c54",
	visual_bell = "#0f0f10",
}

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.color_scheme = "Gruvbox-dark"

-- font
config.font = wezterm.font("Comic Mono", { weight = "Bold" }) -- name as shown by wezterm ls-fonts
config.font_size = 10

-- opacity
config.window_background_opacity = 0.95

-- fps
config.max_fps = 120

-- hide default tab bar
config.hide_tab_bar_if_only_one_tab = true

-- remove padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Finally, return the configuration to wezterm:
return config
