#!/bin/bash

function _setConf(){
    local varname="$1"
    local varvalu="$2"
    local location="$3"
    local replace="$4"
    
    local existing=`grep "${varname}|||" $location`
    if [ "$existing" != "" ]; then
        [ "$replace" = "" ] && echo "$varname already exists, not setting" && return 0;

        # Replace (by removing existing)
        tmp=`mktemp`
        cp $location $tmp # backup purposes
        grep -v "${varname}|||" $location > /tmp/loc_without
        cp /tmp/loc_without $location;
    fi
    
    echo "${varname}|||${varvalu}" >> $location;
}


function _getConf(){
    
    local varname="$1"
    local location="$2"
    local noprompt="$3"

    ! [ -e $location ] && echo "$location does not exist, creating..." && mkdir -p `dirname $location` && touch $location;
    
    varvalu=`grep "${varname}|||" $location | sed -r 's/[^|]+\|\|\|(.*)/\1/'`

    if [ "$varvalu" = "" ]; then
        if [ "$noprompt" != "" ]; then
            return 1; # return error
        fi
        echo "$varname is unset, please set:" && read varvalu
        _setConf $varname $varvalu $location
    fi

    export $varname=$varvalu
}

function getVar(){
    _getConf $1 $SHELL_UTILS_VARFILE $2
}

function getDir(){
    _getConf $1 $SHELL_UTILS_DIRFILE $2
}


function detectShellUtils(){
    
    export SHELL_UTILS_VARFILE=~/.config/ShellUtils/vars
    export SHELL_UTILS_DIRFILE=~/.config/ShellUtils/dirs

    unset SHELL_UTILS
    getDir SHELL_UTILS "noprompt";
   
    if [ "$SHELL_UTILS" = "" ]; then
        # try set loc via zsh
        loc=""
        if [[ "`dirname $0:A`" =~ "/" ]]; then
            loc="`dirname $0:A`"
        else
            # else try via bash
            SOURCE="${BASH_SOURCE[0]}"
            while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
                DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
                SOURCE="$(readlink "$SOURCE")"
                [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
            done
            loc="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        fi

        [ "$loc" = "" ] && echo "Could not resolve script path. Please specify path below" && read loc;
        _setConf SHELL_UTILS $loc $SHELL_UTILS_DIRFILE
        export SHELL_UTILS=$loc

        unset loc
    fi
}

detectShellUtils

. $SHELL_UTILS/core/load_modules.source
loadmod core
loadmod dev
loadmod network

__source_all $SHELL_UTILS/personal_bash/
