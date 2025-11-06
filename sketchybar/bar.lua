-- ============================================================================
-- Bar Appearance Configuration
-- ============================================================================
-- Defines the physical appearance and positioning of the Sketchybar bar itself.
-- This includes dimensions, colors, spacing, and visual effects.
--
-- Settings:
--   - height: Vertical size of the bar in pixels
--   - color: Background color (from colors.lua palette)
--   - padding: Space between bar edge and items
--   - y_offset: Vertical position offset from screen edge
--   - margin: Space between bar and screen edges
--   - corner_radius: Rounded corner effect
--   - blur_radius: Background blur strength for transparency effect
-- ============================================================================

local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
    height = 40,                 -- Bar height in pixels
    color = colors.bar.bg,       -- Background color (Nightfox theme)
    padding_right = 2,           -- Right edge padding
    padding_left = 2,            -- Left edge padding
    y_offset = 2,                -- Vertical offset from screen top
    margin = 5,                  -- Margin from screen edges
    corner_radius = 15,          -- Rounded corners
    blur_radius = 20             -- Background blur effect
})
