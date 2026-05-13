------------------
-- WINDOW RULES --
------------------

-- General
-- Note: two match:class lines in hyprlang implied OR matching, which is invalid in Lua.
-- `.*` already matches everything including empty strings, so one pattern covers both.
hl.window_rule({
    name = "general",
    match = { class = ".*" },
    allows_input = true,
    suppress_event = "maximize",
})

-- Pavucontrol floating
hl.window_rule({
    name = "pavucontrol-floating",
    match = { class = ".*org.pulseaudio.pavucontrol.*" },
    size = { 375, 570 },
    -- Positions window at the right edge, top of the monitor
    move = {
        "min(max(monitor_w*1,0),monitor_w-window_w)",
        "min(max(monitor_h*0,0),monitor_h-window_h)",
    },
    pin = true,
})

-- Discord floating
hl.window_rule({
    name = "discord-floating",
    match = { initial_title = ".*Discord.*" },
    float = true,
    size = { 1600, 1000 },
    center = true,
})

-- PulseUI
hl.window_rule({
    name = "pulseUI-rules",
    match = { class = "pulseUI" },
    size = { 300, 600 },
    center = true,
    allows_input = true,
})

-- Dolphin File Explorer floating
hl.window_rule({
    name = "dolphin-floating",
    match = { class = "org.kde.dolphin" },
    float = true,
    size = { 955, 590 },
})

-- Bitwarden floating
hl.window_rule({
    name = "bitwarden-floating",
    match = { title = "Bitwarden" },
    float = true,
})
