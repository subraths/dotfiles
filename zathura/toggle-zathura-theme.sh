#/usr/bin/env zsh

update_theme() {
  ln -sf $XDG_CONFIG_HOME/zathura/zathurarc-$1 $XDG_CONFIG_HOME/zathura/zathurarc
}

notify_update() {
  notify-send "Zathura theme updated: $1"
}

notify_invalid() {
  notify-send "Invalid argument. Use 'd' or 'dark' for dark theme, 'l' or 'light' for light theme."
}

change_theme() {
  update_theme $1
  notify_update $1
}

case "$1" in
  l|light) change_theme light
  ;;
  d|dark) change_theme dark
  ;;
  *) notify_invalid
  ;;
esac
