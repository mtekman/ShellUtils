#!/bin/bash

core_loc=`pwd`/loadcore.sh
chmod +x $core_loc

bashrc_loc=~/.bashrc
profil_loc=~/.profile

bash_line=". $core_loc"
prof_line=". .bashrc"

find_in_bash=$(grep -c "$bash_line" $bashrc_loc)
find_in_prof=$(grep -c "$prof_line" $profil_loc)

[ "$find_in_bash" != "1" ] && echo "$bash_line" >> $bashrc_loc
[ "$find_in_prof" != "1" ] && echo "$prof_line" >> $profil_loc

echo "Done, please restart bash"
