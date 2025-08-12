return {
	-- Custom wezterm color scheme (minimal)
	-- Save this as e.g. custom.lua and in your wezterm config:
	-- local scheme = require("custom"); wezterm_config.color_schemes = { [scheme.name] = scheme }
	-- then set wezterm_config.color_scheme = scheme.name
	colors = {
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
	},
}
