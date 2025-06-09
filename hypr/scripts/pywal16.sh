#!/usr/bin/env bash

ln -sf ~/.cache/wal/colors-hyprland.conf ~/dotfiles/hypr/conf/
ln -sf ~/.cache/wal/colors-waybar.css ~/dotfiles/waybar/
ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/dotfiles/rofi/shared/

# Reloads hyprland
hyprctl hyprpaper reload ,"$1" # $1 contains wallpaper name


# Reloads waybar
systemctl --user reload waybar.service

notify-send "Wallpaper and colorscheme changed"
