#!/bin/bash

function largestRez() {
    avail_rezes=$(xrandr | egrep "\sconnected\s" | egrep -o "[0-9]+x[0-9]+" );
    total_width=$(( $(echo "$avail_rezes" | awk -F"x" '{print $1}' | tr '\n' "+" | sed 's/\+$//g') ))
    height=$(echo "$avail_rezes" | awk -F"x" '{print $2}' | head -1)
    echo "$total_width $height"
}


function winGeom(){
	if [ "$1" != "" ]; then
		xdotool windowmove $1 $2 $3
		xdotool windowsize $1 $4 $5
	fi
}



rez=$(largestRez)

width=$(echo $rez | awk '{print $1}')
height=$(echo $rez | awk '{print $2}')

h_w=$(echo "$width / 2" | bc)
h_h=$(echo "$height / 2" | bc)
#echo $h_w $h_h
#exit

mplayer_win=$(xdotool search --name mplayer2)
firefox_win=$(xdotool search --name Mozilla)
lightab_win=$(xdotool search --name "Sublime")

[ "$firefox_win" = "" ] && firefox & pid1=$!
[ "$lightab_win" = "" ] && ~/Programs/Sublime\ Text\ 2/sublime_text & sleep 5

[ "$pid1" != "" ] && wait $pid1


firefox_win=$(xdotool search --name Mozilla)
lightab_win=$(xdotool search --name "Light Table")

winGeom $mplayer_win 0 0 $h_w $h_h 2>/dev/null
sleep 1
winGeom $firefox_win 0 $h_h $h_w $h_h
sleep 1
winGeom $lightab_win $h_w 0 $h_w $height
