#!/bin/bash

[ "$(lsmod | grep ^snd_aloop)" = "" ] && sudo modprobe snd_aloop
[ "$(pacmd list | grep module-combine-sink -m 1)" = "" ] && pacmd load-module module-combine-sink
