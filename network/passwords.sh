#!/bin/bash

action=$1
host=$2
salt=$3
pass=$4

passwd_dir="$HOME/.password_hashes"
pass_opts=-aes-256-cbc\ -nosalt\ -pass\ pass:$salt

generatePass(){
	[ $# != 2 ] && echo "generatePass \"<hostname>\" \"<password>\"" && return

	pass=$(echo $2 | openssl enc -base64 -e $pass_opts)
	host=$1
	
	[ -e $passwd_dir ] && off=`grep -n $host $passwd_dir` && [ "$off" != "" ] && echo -e "\"$host\" already found in $passwd_dir.\nPlease remove line `echo $off | awk -F':' '{print $1}'` and try again." >&2 && return
	
	echo -e "$1\t$pass" >> $passwd_dir
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

	[ "$pass" = "" ] && echo "please give hostname, salt, AND password" && exit -1
	generatePass $host $pass
	
elif [ "$action" = "retrieve" ]; then
	[ "$host" = "" ] && echo "please provide a hostname and salt" && exit -1

	retrievePass $host;
else
	echo "`basename $0` (generate|retrieve) <hostname> <salt> [<pass>]" && exit -1
fi
