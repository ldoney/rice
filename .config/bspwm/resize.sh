#!/bin/bash

wid=$(xdotool getactivewindow)
wininfo=$(xwininfo -id "$wid")
width=$(echo "$wininfo" | awk '/Width/ {print $2}')
height=$(echo "$wininfo" | awk '/Height/ {print $2}')
case $1 in
	left)
		# bspc node @east -r -40 || bspc node @west -r -40
		bspc node -z left -40 0
		if [[ $width == "$(xwininfo -id "$wid" | \
				awk '/Width/ {print $2}')" ]]; then
			bspc node -z right -40 0
		fi
		;;
	down)
		# bspc node @south -r +35 || bspc node @north -r +35
		bspc node -z bottom 0 +35
		if [[ $height == "$(xwininfo -id "$wid" | \
				awk '/Height/ {print $2}')" ]]; then
			bspc node -z top 0 +35
		fi
		;;
	up)
		# bspc node @north -r -35 || bspc node @south -r -35
		bspc node -z top 0 -35
		if [[ $height == "$(xwininfo -id "$wid" | \
				awk '/Height/ {print $2}')" ]]; then
			bspc node -z bottom 0 -35
		fi
		;;
	right)
		# bspc node @west -r +40 || bspc node @east -r +40
		bspc node -z right +40 0
		if [[ $width == "$(xwininfo -id "$wid" | \
				awk '/Width/ {print $2}')" ]]; then
			bspc node -z left +40 0
		fi
		;;
esac

