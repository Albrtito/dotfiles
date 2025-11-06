-- ============================================================================
-- Color Palette Configuration
-- ============================================================================
-- Defines all colors used throughout the Sketchybar configuration.
-- Currently using the Nightfox theme with custom adjustments.
--
-- Color Format: 0xAARRGGBB (Alpha, Red, Green, Blue in hexadecimal)
--   - AA: Alpha channel (00=transparent, ff=opaque)
--   - RRGGBB: RGB color values
--
-- Usage: Import this module with `local colors = require("colors")`
-- ============================================================================

return {
    -- Base colors
    black = 0xff181819,
    white = 0xffe2e2e3,
    red = 0xfffc5d7c,
    green = 0xff9ed072,
    blue = 0xff76cce0,
    yellow = 0xffe7c664,
    orange = 0xfff39660,
    magenta = 0xffb39df3,
    grey = 0xff7f8490,
    transparent = 0x00000000,

    -- Bar-specific colors
    bar = {
        --bg = 0xf02c2e34,        -- Original background
        bg = 0xff131a24,          -- Nightfox theming
        --border = 0xff2c2e34,    -- Original border
        border = 0xff1f1f28,      -- Nightfox border
    },
    
    -- Popup menu colors
    popup = {
        bg = 0xff393b44,          -- Popup background
        border = 0xff7f8490,      -- Popup border
    },
    
    -- Background shades for items
    --bg1 = 0xff363944,           -- Original bg1
    bg1 = 0xff212e3f,             -- Nightfox bg1 (darker items)
    --bg2 = 0xff414550,           -- Original bg2
    bg2 = 0xff29394f,             -- Nightfox bg2 (lighter items)

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
