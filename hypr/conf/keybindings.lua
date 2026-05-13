---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local xdgConfig = os.getenv("XDG_CONFIG_HOME")
local variables = require("conf.variables")

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("uwsm app -- " .. variables.terminal .. " +new-window")) -- Open Terminal
hl.bind(mainMod .. " + C", hl.dsp.window.close()) -- Kill active window
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. variables.fileManager)) -- Open File Manager
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- " .. variables.browser .. " --password-store=basic")) -- Open Browser
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(xdgConfig .. "/rofi/scripts/rofi-launcher.sh")) -- Open Rofi
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("uwsm app -- obsidian"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- Toggle Floating
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen()) -- Toggle Fullscreen
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- Toggle Pseudo
hl.bind(mainMod .. " + Apostrophe", hl.dsp.layout("togglesplit")) -- Toggle Split
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(xdgConfig .. "/rofi/scripts/rofi-keybinds.sh")) -- Open Rofi Keybinds
hl.bind("ALT + Tab", hl.dsp.exec_cmd(variables.menu .. ' -show window -theme "' .. xdgConfig .. '/rofi/style.rasi"')) -- Rofi Window Mode

-- Toggle External Screen Only When External Monitor
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd(xdgConfig .. "/hypr/scripts/hypr-montior-external-screen-only.sh"))

-- Move focus with mainMod + vim keybindings
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" })) -- Move Focus Left
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" })) -- Move Focus Down
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "right" })) -- Move Focus Right
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "up" })) -- Move Focus Up

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + Tab", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + Control_L", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + ALT_L", hl.dsp.window.resize(), { mouse = true })

-- Move tiled windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot using hyprshot
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m window")) -- Screenshot Window
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region")) -- Screenshot Region

-- Hyprlock
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock")) -- Lock

-- Cliphist
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy")) -- Rofi Clipboard History

-- Resize submap
-- Switch to a submap called "resize"
hl.bind("ALT + R", hl.dsp.submap("resize")) -- Switch to Resize Submap, Esc to escape

hl.define_submap("resize", function()
    -- Set repeating binds for resizing the active window
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    -- Use reset to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- keybinds further down will be global again...
