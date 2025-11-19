#!/usr/bin/env bash

MUTE=~/.config/hypr/sounds/mute.wav
UNMUTE=~/.config/hypr/sounds/unmute.wav

play_sound() {
    ffplay -nodisp -autoexit -volume 50 "$1">/dev/null 2>&1
}

wpctl set-mute @DEFAULT_SOURCE@ toggle

sleep 0.1

if wpctl get-volume @DEFAULT_SOURCE@ | grep -q MUTED; then
    play_sound $MUTE
else
    play_sound $UNMUTE
fi

