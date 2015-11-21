#!/bin/bash

action=$1
host=$2
salt=$3

[ "$action" = "" ] || [ "$host" = "" ] && echo "`basename $0` ( generate | retrieve ) <hostname> [salt]" && exit -1
[ "$salt" = "" ] && read -s -p "salt: " salt && echo ""

passwd_dir=$HOME/.password_hashes
pass_opts=-aes-256-cbc\ -nosalt\ -pass\ pass:$salt

generatePass(){
	[ $# != 1 ] && echo "generatePass \"<hostname>\" " && return

	read -s -p "pass: " pass
	echo ""
	pass=$(echo $pass | openssl enc -base64 -e $pass_opts)
	host=$1

	if [ -e $passwd_dir ]; then

		# Check for host
		off=`grep -n $host $passwd_dir`
		if [ "$off" != "" ]; then

			# and pass
			old_pass=`grep $host $passwd_dir | awk '{print $2}'`
			[ "$pass" = "$old_pass" ] && echo "[Aborted] $host already exists for that password." && return

			echo -e "\"$host\" already found in $passwd_dir at line `echo $off | awk -F':' '{print $1}'`, but a different password"

			# Replace prompt
			read -p "Replace? [n] " ans
			echo ""
			if [ "$ans" = "y" ]; then
				sed -i "s/$host.*/$host\t$pass/" $passwd_dir	#replace
				echo "[Updated] Hash for \"$host\" saved  to $passwd_dir" >&2
				return
			fi

			echo "[Aborted]"
			return
		fi
	fi

	echo -e "$host\t$pass" >> $passwd_dir
	echo ""
	echo "[Done] Hash for \"$host\" saved to $passwd_dir"
}

retrievePass(){
	[ $# != 1 ] && echo "retrievePass <hostname>" && return
	
	line=$( grep $1 $passwd_dir )
	[ "$line" = "" ] && echo "Could not find \"$1\" in $passwd_dir" && return -1
	
	pass_hash=$(echo $line | awk '{print $2}')
	echo "$pass_hash" | openssl enc -base64 -d $pass_opts
}


if [ "$action" = "generate" ]; then
	generatePass $host
	
elif [ "$action" = "retrieve" ]; then
	retrievePass $host;
else
	echo "Invalid option" && exit -1
fi
