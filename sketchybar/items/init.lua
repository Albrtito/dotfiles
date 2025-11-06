-- Load all bar items in order from left to right
-- Left side items
require("items.apple")        -- Apple logo menu
require("items.menus")        -- Menu system
--require("items.spaces")     -- Original spaces (replaced by aerospaces)
require("items.aerospaces")   -- Aerospace workspace indicators
require("items.front_app")    -- Currently focused application

-- Right side items (loaded in reverse order due to right positioning)
-- Visual order (left to right): media, widgets, pomodoro, calendar
-- Load order (reversed):
require("items.calendar")     -- Date and time display (rightmost)
require("items.pomodoro")     -- Pomodoro productivity timer
require("items.widgets")      -- System widgets (CPU, WiFi, Volume, Battery)
require("items.media")        -- Media player controls (Spotify/Music) (leftmost of right side)
