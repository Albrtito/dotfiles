local settings = require("settings")
local colors = require("colors")

-- Pomodoro Timer Module
-- =====================
-- A productivity timer that alternates between work (25 min) and break (5 min) sessions.
--
-- Interaction:
--   - Double-click: Start/Stop the timer
--   - Single-click: Toggle between work timer (25 min) and break timer (5 min)
--
-- Behavior:
--   - Timer counts down from the set duration
--   - When time expires, turns red and counts up (overtime tracking)
--   - Displays time in MM:SS format
--   - Icon changes based on state (paused vs running)

-- Padding item for spacing before pomodoro
sbar.add("item", { position = "right", width = settings.group_paddings })

-- Main pomodoro timer item
local pomodoro = sbar.add("item", "pomodoro", {
  position = "right",
  icon = {
    string = "􀐱",  -- Clock/timer icon (pause state initially)
    color = colors.white,
    padding_left = 8,
    font = {
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
  },
  label = {
    string = "25:00",  -- Initial display (25 minute work timer)
    color = colors.white,
    padding_right = 8,
    width = 49,
    align = "right",
    font = { 
      family = settings.font.numbers,
      size = 13.0,
    },
  },
  update_freq = 1,  -- Update every second for accurate countdown
  padding_left = 1,
  padding_right = 1,
  background = {
    color = colors.bg2,
    border_color = colors.black,
    border_width = 1
  },
})

-- Double border effect using a bracket (matches calendar style)
sbar.add("bracket", { pomodoro.name }, {
  background = {
    color = colors.transparent,
    height = 30,
    border_color = colors.grey,
  }
})

-- Padding item after pomodoro for spacing
sbar.add("item", { position = "right", width = settings.group_paddings })

-- Track click timing for single vs double-click detection
local last_click_time = 0
local click_timer = nil

-- Handle mouse clicks with single/double-click distinction
pomodoro:subscribe("mouse.clicked", function(env)
  local current_time = os.time()
  local time_since_last_click = current_time - last_click_time
  
  -- Double-click detected (within 0.5 seconds)
  if time_since_last_click < 1 and click_timer then
    -- Cancel single-click action
    if click_timer then
      click_timer = nil
    end
    
    -- Execute double-click: toggle timer start/stop
    sbar.exec("$CONFIG_DIR/helpers/pomodoro.sh toggle_timer")
  else
    -- Potential single-click, wait to confirm it's not a double-click
    last_click_time = current_time
    
    -- Set a timer to execute single-click action if no second click comes
    click_timer = true
    sbar.delay(1, function()
      if click_timer then
        -- Execute single-click: switch timer type (work <-> break)
        sbar.exec("$CONFIG_DIR/helpers/pomodoro.sh switch_type")
        click_timer = nil
      end
    end)
  end
end)

-- Regular update subscription (runs every second due to update_freq = 1)
-- This keeps the timer display updated in real-time
pomodoro:subscribe({ "routine", "forced" }, function(env)
  sbar.exec("$CONFIG_DIR/helpers/pomodoro.sh update")
end)
