-- ============================================================================
-- Global Settings Configuration
-- ============================================================================
-- Defines global settings used across all Sketchybar items.
-- These settings ensure consistency in spacing, fonts, and icon styles.
--
-- Settings:
--   - paddings: Space within items (between content and borders)
--   - group_paddings: Space between groups of items
--   - icons: Icon set to use (sf-symbols or NerdFont)
--   - font: Font configuration for text and numbers
-- ============================================================================

return {
  paddings = 3,              -- Internal padding for all items
  group_paddings = 5,        -- Spacing between item groups

  icons = "sf-symbols",      -- Icon set: "sf-symbols" or "NerdFont"

  -- This is a font configuration for SF Pro and SF Mono (installed manually)
  font = require("helpers.default_font"),

  -- Alternatively, this is a font config for JetBrainsMono Nerd Font
  -- Uncomment and modify if you prefer NerdFont icons and fonts
  -- font = {
  --   text = "JetBrainsMono Nerd Font", -- Used for text
  --   numbers = "JetBrainsMono Nerd Font", -- Used for numbers
  --   style_map = {
  --     ["Regular"] = "Regular",
  --     ["Semibold"] = "Medium",
  --     ["Bold"] = "SemiBold",
  --     ["Heavy"] = "Bold",
  --     ["Black"] = "ExtraBold",
  --   },
  -- },
}
