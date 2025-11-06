local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Add aerospace workspace change event
sbar.exec("sketchybar --add event aerospace_workspace_change")

-- Get all workspaces from aerospace
local handle = io.popen("aerospace list-workspaces --all")
local aerospace_workspaces = {}
if handle then
	for workspace in handle:lines() do
		table.insert(aerospace_workspaces, workspace)
	end
	handle:close()
end

local spaces = {}

-- Sets a name to each space based on their sid
-- Maps workspace IDs to visual icons for easy identification
local function space_name(sid)
	local space_icons = {
		["1"] = "󰊠",  -- Ghostty terminal (keeping original for now)
		["2"] = "󰠮",  -- Obsidian note-taking app
		["3"] = "􀤆",  -- Arc browser
		["4"] = "􀉉",  -- Calendar
		["5"] = "􀍝",  -- Messages
		["6"] = "􀥯",  -- Generic app icon
		["7"] = "󰓇",  -- Spotify music player
		-- Add more mappings as needed
	}

	-- Return the icon if it exists, otherwise return the sid as a fallback
	return space_icons[sid] or sid
end

-- Create spaces for each aerospace workspace
for _, sid in ipairs(aerospace_workspaces) do
	local space = sbar.add("item", sid, {
		position = "left", -- Changed from "center" to "left"
		icon = {
			font = { family = settings.font.numbers },
			string = space_name(sid),
			padding_left = 15,
			padding_right = 8,
			color = colors.white,
			highlight_color = colors.red, -- Using colors.red instead of hardcoded
		},
		label = {
			padding_right = 6,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0", -- Changed back to original font
			y_offset = -1,
		},
        display = "active",
		padding_right = 1,
		padding_left = 1,
		background = {
			color = colors.bg1,
			border_width = 1,
			height = 26,
			border_color = colors.black,
		},
		popup = { background = { border_width = 5, border_color = colors.black } },
		click_script = "aerospace workspace " .. sid,
		script = "../helpers/aerospace/spaces.sh " .. sid,
	})

	spaces[sid] = space

	-- Single item bracket for space items to achieve double border on highlight
	local space_bracket = sbar.add("bracket", { space.name }, {
		background = {
			color = colors.transparent,
			border_color = colors.bg2,
			height = 28,
			border_width = 2,
		},
	})

	-- Padding space (important for proper spacing)
	sbar.add("item", "space.padding." .. sid, {
		position = "left",
		script = "",
		width = settings.group_paddings,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	-- Subscribe to aerospace workspace change event
	space:subscribe("aerospace_workspace_change", function(env)
		local selected = env.SELECTED == "true" or env.FOCUSED_WORKSPACE == sid
		local color = selected and colors.grey or colors.bg2

		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_color = selected and colors.black or colors.bg2 },
		})

		space_bracket:set({
			background = { border_color = selected and colors.grey or colors.bg2 },
		})
	end)

	-- Handle mouse clicks with proper button detection
	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
			sbar.exec("aerospace workspace " .. sid)
		end
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

-- Add aerospace window observer
local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
  local icon_line = ""
  local no_app = true
  for app, count in pairs(env.INFO.apps) do
    no_app = false
    local lookup = app_icons[app]
    local icon = ((lookup == nil) and app_icons["Default"] or lookup)
    icon_line = icon_line .. icon
  end

  if (no_app) then
    icon_line = " —"
  end
  sbar.animate("tanh", 10, function()
    spaces[env.INFO.space]:set({ label = icon_line })
  end)
end)



-- Spaces indicator removed - no longer needed for toggle functionality

-- Handle window changes and app tracking
space_window_observer:subscribe("aerospace_workspace_change", function(env)
	local icon_line = ""
	local no_app = true

	-- Get current workspace apps (you'll need to implement this in your aerospace script)
	if env.INFO and env.INFO.apps then
		for app, count in pairs(env.INFO.apps) do
			no_app = false
			local lookup = app_icons[app]
			local icon = ((lookup == nil) and app_icons["Default"] or lookup)
			icon_line = icon_line .. icon
		end
	end

	-- Update the appropriate space with app icons
	if env.FOCUSED_WORKSPACE and spaces[env.FOCUSED_WORKSPACE] then
		spaces[env.FOCUSED_WORKSPACE]:set({
			label = { string = icon_line },
		})
	end
end)
