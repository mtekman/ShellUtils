#!/bin/bash

function largestRez() {
    avail_rezes=$(xrandr | egrep "\sconnected\s" | egrep -o "[0-9]+x[0-9]+" );
    total_width=$(( $(echo "$avail_rezes" | awk -F"x" '{print $1}' | tr '\n' "+" | sed 's/\+$//g') ))
    height=$(echo "$avail_rezes" | awk -F"x" '{print $2}' | head -1)
    echo "$total_width $height"
}


function winGeom(){
	nam=$1
	[ "$1" != "" ] && xdotool windowmove $nam $2 $3	# positions
	[ "$4" != "" ] && xdotool windowsize $nam $4 $5 # dimension
}


# Grabs the earliest process
rez=1
function xsearch(){
	rez=1
	win="$(xdotool search --onlyvisible --name $1)"
	rez=$?
	echo "$win" | sort | head -1
}


# Polls until exists
function waitWindow(){
	name=$1
	check_once=$2

	win=$(xsearch $name)
	if [ "$check_once" != "" ]; then
		echo $win
	else
		while [ "$rez" = "1" ] || [ "$win" = "" ]; do win=$(xsearch $name); sleep 1; done
		echo $win
	fi
}

# Globals
rez=$(largestRez)

width=$(echo $rez | awk '{print $1}')
height=$(echo $rez | awk '{print $2}')

h_w=$(echo "$width / 2" | bc)
h_h=$(echo "$height / 2" | bc)


# Programs
firefox=firefox
sublime=~/Programs/Sublime_Text_2/sublime_text
pomodor=tomate

# Initial scan
f_win=$(waitWindow Mozilla 1)
s_win=$(waitWindow Sublime 1)
p_win=$(waitWindow Tomate 1)

# Spawn those not up
[ "$f_win" = "" ] && $firefox &
[ "$s_win" = "" ] && $sublime &
[ "$p_win" = "" ] && $pomodor &

sleep 1

# Poll until exists
f_win=$(waitWindow Mozilla)
s_win=$(waitWindow Sublime)
p_win=$(waitWindow Tomate)


winGeom $s_win 0 0 $h_w $height
sleep 1

y_div=$(( $height - 100 ))

winGeom $f_win $h_w 0 $h_w $y_div
sleep 1
winGeom $p_win $h_ $y_div
