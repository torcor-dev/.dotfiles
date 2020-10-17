#!/bin/zsh
xrandr --output eDP1 --auto --output DP1 --auto --right-of eDP1  
picom &
nitrogen --restore &
mullvad-vpn &
breaktimer &
# pulseaudio -D
