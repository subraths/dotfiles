#! /bin/sh

iDIR="$HOME/.config/mako/icons/wifi.png"

get_icon() {
  echo "$iDIR"

}

mapfile -t known < <(ls /var/lib/iwd | awk -F. '{print $1}')
mapfile -t available < <(iwctl station wlan0 get-networks | awk 'NR>4 {print $1}')

for k in "${known[@]}"; do
    if printf '%s\n' "${available[@]}" | grep -Fxq "$network"; then
    echo "Found: $network"
  else
    echo "Not found: $network"
  fi

done

echo ${known}


#! /bin/sh

iDIR="$HOME/.config/mako/icons/wifi.png"

get_icon() {
  echo "$iDIR"

}



iwctl station wlan0 scan
# iwctl station wlan0 connect AndroidAP_6771

sleep 1
mapfile -t known < <(ls /var/lib/iwd | awk -F. '{print $1}')

sleep 1

# search for known devices

connected = 0
for network in "${known[@]}"; do
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Searching for $network"
  if iwctl station wlan0 get-networks | grep -q "$network"; then
    iwctl station wlan0 connect "$network"
    sleep 1
    connected_network=$(iwctl station wlan0 get-networks | grep -i ">" | awk '{print $4}')
    connected=1
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Connected to $connected_network"
    break
  else
      notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "$network"
  fi
done

