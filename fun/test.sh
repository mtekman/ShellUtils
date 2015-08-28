# Start rin
screen -S rin -m -d
screen -S rin -X stuff "loadmod fun;findrin
#"

# Start screen man page
screen -S man -m -d
screen -S man -X stuff "man --pager='less +2050' screen
#"

# Start irssi
screen -S irssi -m -d
#screen -S irssi -X stuff "irssi -c Rizon
#"

# Start visualizer
screen -S vis -m -d

# Start empty shell
screen -S mt -m -d

# Begin positioning
screen -S main
screen -S main -X stuff "

xdotool key ctrl+a key ctrl+S
xdotool key ctrl+a key ctrl+|
xdotool key ctrl+a key Tab
xdotool key ctrl+a key ctrl+S
xdotool key ctrl+a key ctrl+S


#screen -r main
