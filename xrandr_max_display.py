#!/usr/bin/env python2

import sys

text=sys.argv[1].splitlines()

index= 0

max_device=""
max_rez=""
max_res=0

device_list=[]

while index < len(text):
	t = text[index]
	tokes = t.split()
	status=tokes[1].strip()
	dev = tokes[0].strip()

	if status=="connected":
		device_list.append(dev)
		max = text[index+1].split()[0]
#		print max
		x,y = map(int, max.split('x'))
		max2 = x*y
		if max2 > max_res:
			max_res = max2
			max_rez = max
			max_device = dev
	elif status=="disconnected":
		device_list.append(dev)

	index +=1


device_list.remove(max_device)

out="xrandr --output %s --auto" % max_device
for d in device_list:
	out += " --output %s --off" % d

print out
