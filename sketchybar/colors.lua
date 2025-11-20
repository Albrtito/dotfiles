-- ============================================================================
-- Color Palette Configuration
-- ============================================================================
-- Defines all colors used throughout the Sketchybar configuration.
-- Now using the TokyoNight Night theme.
--
-- Color Format: 0xAARRGGBB (Alpha, Red, Green, Blue in hexadecimal)
--   - AA: Alpha channel (00=transparent, ff=opaque)
--   - RRGGBB: RGB color values
--
-- Usage: Import this module with `local colors = require("colors")`
-- ============================================================================

return {
    -- Base colors (TokyoNight Night theme)
    black = 0xff1a1b26,      -- #1a1b26 - Background
    white = 0xffc0caf5,      -- #c0caf5 - Foreground
    red = 0xfff7768e,        -- #f7768e - Red
    green = 0xff9ece6a,      -- #9ece6a - Green
    blue = 0xff7aa2f7,       -- #7aa2f7 - Blue
    yellow = 0xffe0af68,     -- #e0af68 - Yellow
    orange = 0xffff9e64,     -- #ff9e64 - Orange
    magenta = 0xffbb9af7,    -- #bb9af7 - Magenta
    cyan = 0xff7dcfff,       -- #7dcfff - Cyan
    grey = 0xff565f89,       -- #565f89 - Comment/Gray
    
    transparent = 0x00000000,

    -- Bar-specific colors
    bar = {
        bg = 0xff1a1b26,          -- TokyoNight background
        border = 0xff1a1b26,      -- TokyoNight border (same as bg)
    },
    
    -- Popup menu colors
    popup = {
        bg = 0xff202331,          -- Slightly lighter than bg
        border = 0xff565f89,      -- Comment/Gray color
    },
    
    -- Background shades for items
    bg1 = 0xff202331,             -- Darker items
    bg2 = 0xff292e42,             -- Lighter items

    -- Utility function to adjust color opacity
    -- Params: color (0xAARRGGBB), alpha (0.0-1.0)
    -- Returns: color with modified alpha channel
    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
    end,
}
