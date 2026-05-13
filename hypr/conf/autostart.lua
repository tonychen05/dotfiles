-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("uwsm app -- quickshell")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- hypridle")
    hl.exec_cmd("uwsm app -- fcitx5")
    hl.exec_cmd("uwsm app -- udiskie")
    hl.exec_cmd("wl-paste --watch cliphist store") -- Listen for clipboard changes
    hl.exec_cmd("wl-clip-persist --clipboard regular") -- Wayland Clipboard Persist
end)
