#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_updates_yay() { 
    UPDATES_YAY=$(sh $XDG_CONFIG_HOME/polybar/scripts/checkupdates yay 2> /dev/null); 
    UPDATES_COUNT_YAY=$(echo "$UPDATES_YAY" | sed '/^\s*$/d' | wc -l)
}

get_updates_pacman() { 
    UPDATES_PACMAN=$(sh $XDG_CONFIG_HOME/polybar/scripts/checkupdates pacman 2> /dev/null); 
    UPDATES_COUNT_PACMAN=$(echo "$UPDATES_PACMAN" | sed '/^\s*$/d' | wc -l)
}

get_total_updates() { 
    get_updates_yay
    get_updates_pacman
    UPDATES=$((UPDATES_COUNT_PACMAN + UPDATES_COUNT_YAY))
}

while true; do
    get_total_updates

    # notify user of updates
    if hash notify-send &>/dev/null; then
        if (( UPDATES > 50 )); then
            notify-send -u critical -i $NOTIFY_ICON \
                "You really need to update!!" "$UPDATES New packages"
        elif (( UPDATES > 25 )); then
            notify-send -u normal -i $NOTIFY_ICON \
                "You should update soon" "$UPDATES New packages"
        elif (( UPDATES > 2 )); then
            notify-send -u low -i $NOTIFY_ICON \
                "$UPDATES New packages"
        fi
    fi

    # when there are updates available
    # every 10 seconds another check for updates is done
    while (( UPDATES > 0 )); do
        if (( UPDATES == 1 )); then
            echo " yay: $UPDATES_COUNT_YAY pacman: $UPDATES_COUNT_PACMAN"
        elif (( UPDATES > 1 )); then
            echo " yay: $UPDATES_COUNT_YAY pacman: $UPDATES_COUNT_PACMAN"
        else
            echo " None"
        fi
        sleep 10
        get_total_updates
    done

    # when no updates are available, use a longer loop, this saves on CPU
    # and network uptime, only checking once every 30 min for new updates
    while (( UPDATES == 0 )); do
        echo " None"
        sleep 1800
        get_total_updates
    done
done
