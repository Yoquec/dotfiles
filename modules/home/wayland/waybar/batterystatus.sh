set -euo pipefail

battery=$(upower --enumerate | head -n1)
battery_info=$(upower -i "${battery}" | grep -E "icon|percentage" | awk '{ printf "%s\n", $2 }')
battery_status=$(echo "${battery_info}" | grep -v '%')
battery_percentage=$(echo "${battery_info}" | grep '%')
battery_level=$(echo "${battery_percentage}" | tr -d '%')

get_icon() {
    if [[ $1 -ge 75 ]]; then
        echo ""
    elif [[ $1 -ge 50 ]]; then
        echo ""
    elif [[ $1 -ge 25 ]]; then
        echo ""
    elif [[ $1 -ge 10 ]]; then
        echo ""
    else
        echo ""
    fi
}

icon=$(get_icon "${battery_level}")

if [[ -z $(echo "${battery_status}" | grep charg) ]]; then
    echo "${icon} ${battery_percentage}"
else
    echo "${icon} ${battery_percentage} "
fi
