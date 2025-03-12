local wezterm = require("wezterm")
return {
    --SET THE THEME
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 16.0,
	font = wezterm.font_with_fallback({
        "Monaspace Argon",
		"JetBrains Mono",
        "Iosevka Term",
	}),
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,

    --SET THE BACKGROUND IMAGE
    -- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },

    --SET THE OPACITY OF THE BACKGROUND IMAGE
	window_background_opacity = 1,
	window_decorations = "RESIZE",
    -- MOUSE SETTINGS:
    mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
