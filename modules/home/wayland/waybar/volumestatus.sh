volume_perc=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ printf "%s\n", $5 }')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ printf "%s\n", $2}')

if [[ $mute == "yes" ]]; then
    echo "󰖁"
else
    echo "󰕾 $volume_perc"
fi
