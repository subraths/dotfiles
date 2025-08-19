#! /bin/sh

iDIR="$HOME/.config/mako/icons/wifi.png"

get_icon() {
  echo "$iDIR"
}

iwctl station wlan0 scan
# iwctl station wlan0 connect AndroidAP_6771
notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Scanning wifi"

sleep 1

known_devices=("AndroidAP_1996" "desktop")
sleep 1

# search for known devices

connected = 0
for network in "${known_devices[@]}"; do
  if iwctl station wlan0 get-networks | grep -q "$network"; then
    iwctl station wlan0 connect "$network"
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Connecting to $network"
    sleep 1
    connected_network=$(iwctl station wlan0 get-networks | grep -i ">" | awk '{print $4}')
    connected=1
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Connected to $connected_network"
    break
  fi
done

if [ $connected -eq 0 ]; then
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "No known networks found"
fi

