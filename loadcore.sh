#!/bin/bash
git_loc=/nomansland/MAIN_REPOS/

. $git_loc/bash_global/core/load_modules.source
loadmod core
loadmod dev
loadmod network

__source_all $git_loc/personal_bash/
