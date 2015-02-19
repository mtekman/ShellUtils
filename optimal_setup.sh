#!/bin/bash

function winGeom(){
	if [ "$1" != "" ]; then
		xdotool windowmove $1 $2 $3
		xdotool windowsize $1 $4 $5
	fi
}



rez=$(xdotool getdisplaygeometry)
width=$(echo $rez | awk '{print $1}')
height=$(echo $rez | awk '{print $2}')

h_w=$(echo "$width / 2" | bc)
h_h=$(echo "$height / 2" | bc)
#echo $h_w $h_h
#exit

mplayer_win=$(xdotool search --name mplayer2)
firefox_win=$(xdotool search --name Mozilla)
lightab_win=$(xdotool search --name "Light Table")

[ "$firefox_win" = "" ] && firefox &
firefox_win=$(xdotool search --name Mozilla)

[ "$lightab_win" = "" ] && ~/Programs/LightTable/LightTable &
lightab_win=$(xdotool search --name "Light Table")


winGeom $mplayer_win 0    0     $h_w  $h_h
winGeom $firefox_win 0    $h_h  $h_w  $h_h
winGeom $lightab_win $h_w 0     $h_w  $height
