-- ============================================================================
-- Sketchybar Main Initialization
-- ============================================================================
-- This file orchestrates the loading of all Sketchybar configuration modules.
--
-- Configuration Structure:
--   1. bar.lua       - Physical bar appearance (height, position, styling)
--   2. default.lua   - Default styles applied to all items
--   3. items/        - Individual bar items (workspaces, widgets, etc.)
--
-- The configuration is bundled and sent to Sketchybar in a single message
-- for better performance, then the event loop handles real-time updates.
-- ============================================================================

-- Require the sketchybar module
sbar = require("sketchybar")

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
-- This improves performance by reducing IPC calls
sbar.begin_config()
require("bar")       -- Bar appearance and positioning
require("default")   -- Default styles for all items
require("items")     -- Load all bar items
sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
