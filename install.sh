#!/bin/bash

core_loc=`pwd`/loadcore.sh
chmod +x $core_loc

bashrc_loc=~/.bashrc
zzshrc_loc=~/.zshrc
profil_loc=~/.profile


# same for now
bash_line=". $core_loc"
zzsh_line=". $core_loc"
prof_line=". $core_loc"


find_in_bash=$(grep -c "$bash_line" $bashrc_loc)
find_in_zzsh=$(grep -c "$zzsh_line" $zzshrc_loc)
find_in_prof=$(grep -c "$prof_line" $profil_loc)

[ "$find_in_bash" = "0" ] && echo "$bash_line" >> $bashrc_loc
[ "$find_in_zzsh" = "0" ] && echo "$zzsh_line" >> $zzshrc_loc
[ "$find_in_prof" = "0" ] && echo "$prof_line" >> $profil_loc

# Install custom oh-my-zsh theme
omz_loc=/usr/share/oh-my-zsh/themes/tetris.zsh-theme
thm_loc=`find $(pwd) -name tetris-zsh-theme.source`
! [ -e $omz_loc ] && sudo ln -s $thm_loc $omz_loc

echo "Done, please restart the shell"
