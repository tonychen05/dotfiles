hl.monitor({
    output = "eDP-1",
    mode = "highres",
    position = "auto",
    scale = "1",
    bitdepth = 8,
})

hl.monitor({
    output = "DP-4",
    mode = "1280x800",
    position = "auto-right",
    scale = "1",
    bitdepth = 8,
})

require("conf.environment")
require("conf.keybindings")
require("conf.autostart")
require("conf.windowrules")
require("conf.input")
require("conf.lookandfeel")
