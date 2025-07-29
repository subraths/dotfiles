#/usr/bin/env bash

if [[ $1 == dark || $1 == light ]]; then
  ln -sf $XDG_CONFIG_HOME/zathura/zathurarc-$1 $XDG_CONFIG_HOME/zathura/zathurarc
  notify-send "Toggle zathura theme" "Zathura theme updated: $1"
else
  notify-send "Toggle zathura theme" "Invalid param: $1"
fi
