-- ============================================================================
-- Media Player Module
-- ============================================================================
-- Displays currently playing media with album artwork, artist, and title.
-- Only shows when media is actively playing in whitelisted applications.
--
-- Whitelisted Apps: Spotify, Music
--
-- Features:
--   - Album artwork display
--   - Artist and title information (shows on hover)
--   - Media controls popup (previous, play/pause, next)
--   - Auto-hides when media is paused or stopped
--   - Animations for smooth transitions
--
-- Dependencies: nowplaying-cli (must be installed via Homebrew)
-- ============================================================================

local icons = require("icons")
local colors = require("colors")

-- Only show media info for these applications
local whitelist = { ["Spotify"] = true,
                    ["Music"] = true    };

-- Create a hidden item to poll for media updates
-- This is a workaround for when native media events don't work
local media_poller = sbar.add("item", "media_poller", {
  drawing = false,
  update_freq = 5,  -- Poll every 5 seconds
  script = "$CONFIG_DIR/helpers/media_poll.sh"
})

local media_cover = sbar.add("item", "media_cover", {
  position = "right",
  background = {
    image = {
      string = "media.artwork",
      scale = 0.85,
    },
    color = colors.transparent,
  },
  label = { drawing = false },
  icon = { drawing = false },
  drawing = false,
  updates = true,
  popup = {
    align = "center",
    horizontal = true,
  }
})

local media_artist = sbar.add("item", "media_artist", {
  position = "right",
  drawing = false,
  padding_left = 3,
  padding_right = 0,
  width = 0,
  icon = { drawing = false },
  label = {
    width = 0,
    font = { size = 9 },
    color = colors.with_alpha(colors.white, 0.6),
    max_chars = 18,
    y_offset = 6,
  },
})

local media_title = sbar.add("item", "media_title", {
  position = "right",
  drawing = false,
  padding_left = 3,
  padding_right = 0,
  icon = { drawing = false },
  label = {
    font = { size = 11 },
    width = 0,
    max_chars = 16,
    y_offset = -5,
  },
})

sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.back },
  label = { drawing = false },
  click_script = "nowplaying-cli previous",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  click_script = "nowplaying-cli next",
})

local interrupt = 0
local function animate_detail(detail)
  if (not detail) then interrupt = interrupt - 1 end
  if interrupt > 0 and (not detail) then return end

  sbar.animate("tanh", 30, function()
    media_artist:set({ label = { width = detail and "dynamic" or 0 } })
    media_title:set({ label = { width = detail and "dynamic" or 0 } })
  end)
end

media_cover:subscribe("media_change", function(env)
  if whitelist[env.INFO.app] then
    local drawing = (env.INFO.state == "playing")
    media_artist:set({ drawing = drawing, label = env.INFO.artist, })
    media_title:set({ drawing = drawing, label = env.INFO.title, })
    media_cover:set({ drawing = drawing })

    if drawing then
      animate_detail(true)
      interrupt = interrupt + 1
      sbar.delay(5, animate_detail)
    else
      media_cover:set({ popup = { drawing = false } })
    end
  end
end)

media_cover:subscribe("mouse.entered", function(env)
  interrupt = interrupt + 1
  animate_detail(true)
end)

media_cover:subscribe("mouse.exited", function(env)
  animate_detail(false)
end)

media_cover:subscribe("mouse.clicked", function(env)
  media_cover:set({ popup = { drawing = "toggle" }})
end)

media_title:subscribe("mouse.exited.global", function(env)
  media_cover:set({ popup = { drawing = false }})
end)
