#!/bin/bash

cwd=`pwd`
[ "ShellUtils" != "`basename $cwd`" ] && echo "
Please run the install script from the ShellUtils directory" && exit -1


core_loc=$cwd/loadcore.sh
chmod +x $core_loc

bashrc_loc=~/.bashrc
zzshrc_loc=~/.zshrc
profil_loc=~/.profile


# same for now
bash_line=". $core_loc"
zzsh_line=". $core_loc"
prof_line=". $core_loc"


[ -e $bashrc_loc ] && find_in_bash=$(grep -c "$bash_line" $bashrc_loc)
[ -e $zzshrc_loc ] && find_in_zzsh=$(grep -c "$zzsh_line" $zzshrc_loc)
[ -e $profil_loc ] && find_in_prof=$(grep -c "$prof_line" $profil_loc)

[ "$find_in_bash" = "0" ] && echo "$bash_line" >> $bashrc_loc
[ "$find_in_zzsh" = "0" ] && echo "$zzsh_line" >> $zzshrc_loc
[ "$find_in_prof" = "0" ] && echo "$prof_line" >> $profil_loc

# Install custom oh-my-zsh theme
omz_loc=~/.oh-my-zsh/themes/tetris.zsh-theme
thm_loc=`find $cwd -name tetris-zsh-theme.source`
! [ -e $omz_loc ] && ln -s $thm_loc $omz_loc

# Set dirs
config_dir=~/.config/ShellUtils
mkdir -p $config_dir
echo "SHELL_UTILS|||$cwd" > $config_dir/dirs


if [ "$find_in_bash" = "0" ] || [ "$find_in_zzsh" = "0" ] || [ "$find_in_prof" = "0" ];
then
    echo "Done, please restart the shell"
else
    echo "Nothing updated."
fi
