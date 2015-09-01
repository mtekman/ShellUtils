#!/bin/bash

xfce4-terminal --geometry=110x38
w_id=$( xdotool search Terminal | sort | tail -1  2>/dev/null )

xdotool windowfocus $w_id

function xdotype {
	xdotool type "$*"
	xdotool key Return
}

function scont {
	xdotool key ctrl+a
}

function splitH {
	scont
	xdotype ":split -v"
	sleep 0.2
}

function splitV {
	scont
	xdotype ":split"
	sleep 0.2
}

function next {
	scont
	xdotool key Tab
}

function init {
	scont
	xdotool key ctrl+c
	sleep 0.2
}

xdotype "screen -S yaroy"
splitH

next
init
splitV
#xdotype "[ \"$(lsmod | grep ^snd_aloop)\" = \"\" ] && sudo modprobe snd_aloop; [ \"$(pacmd list | grep module-combine-sink -m 1)\" = \"\" ] && pacmd load-module module-combine-sink"
xdotype "cava -s 200"

next
init
splitV
xdotype "loadmod fun; findrin"

next
init
xdotype "irssi"

next
splitV
xdotype "man --pager='less +2050' screen"

next
init

echo $w_id
