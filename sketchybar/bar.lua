local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
    height = 40,
    color = colors.bar.bg,
    padding_right = 2,
    padding_left = 2,
    y_offset = 2,
    margin = 5,
    corner_radius = 15,
    blur_radius = 20
})
