#!/bin/bash

journal_loc=/nomansland/personal_scripts/journal/


function collateAllFromDay(){
    ! [ -e $journal_loc ] && mkdir $journal_loc


    ymd="$1" # yyyy_mm_dd

    files=`find $journal_loc -type f -name "$ymd\__*.txt"`
    files_sorted=$( echo "$files" | sort -n );

    cat $files_sorted > $journal_loc/$ymd.summary
    echo "Collated $ymd"


    [ "$files_sorted" != "" ]\
	&& echo "Remove: $files_sorted ? [y/n]" && read ans\
	&& [ "$ans" = "y" ] && rm $files_sorted
}


# Work, Home, Mind, Body
# - More than 3 hours
# - Learned about how to fix something
# - Wont or will, music, caffeine, water
# - Ride, run, avoid sweet/diet, avoid chocolate.

function makeEntry(){
    ! [ -e $journal_loc ] && mkdir $journal_loc

    checkPreviousDatesForCollation;

    minutestamp="`date +%Y_%m_%d__%H_%M`"

    newfile=$journal_loc/$minutestamp.txt

    emacs $newfile
}


function checkPreviousDatesForCollation(){

    today=`date +%Y_%m_%d`

    uniq_dats=`find $journal_loc/ -type f -name "*.txt"`
#    echo "$uniq_dats"
#    echo "$uniq_dats" | grep -oP "\d{4}_\d{2}_\d{2}" | sort | uniq 
    
    tobecollated=`echo "$uniq_dats" | grep -oP "[0-9]{4}_[0-9]{2}_[0-9]{2}"\
 | sort | uniq |\
 grep -v $today`

#    echo "$tobecollated"
      
    [ "$tobecollated" != "" ] && for ymd in $tobecollated; do collateAllFromDay $ymd; done;  
}

#function grabLast


#makeEntry
