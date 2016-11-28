
# Takes one reminder and displays it for each bash
function showReminder(){
	remfile=/nomansland/personal_scripts/reminder.txt;

	! [ -e $remfile ] && echo "Reminder not found " >&2 && emacs $remfile;

	numlines=`grep -v "^$" $remfile | wc -l`;

	randomline=`echo " $RANDOM % $numlines " | bc`; # 0 -> numlines - 1
	line=$(( $randomline + 1 ))

	outline=`cat $remfile | head -$line | tail -1`;
	echo -e "$txtylw$outline$txtrst"
}

showReminder
