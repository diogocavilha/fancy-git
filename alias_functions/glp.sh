#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     09.01.2016
#
# SEARCH GIT LOG
#
# Perform a pretty git log
# Perform search in git log

logCmd="git log --date=short --pretty=format:'%C(bold yellow)%h%C(reset) %C(white)%ad %C(bold blue)(%ar)%C(reset) %C(bold green)%an %C(reset)%C(cyan)%s%C(reset)'"

if [ "$1" != "" ]; then
    logCmd=$logCmd" | grep -i \"$1\""
fi

if [ "$2" != "" ]; then
    logCmd=$logCmd" | grep -i \"$2\""
fi

if [ "$3" != "" ]; then
    logCmd=$logCmd" | grep -i \"$3\""
fi

if [ "$4" != "" ]; then
    logCmd=$logCmd" | grep -i \"$4\""
fi

if [ "$5" != "" ]; then
    logCmd=$logCmd" | grep -i \"$5\""
fi

eval $logCmd
commitCount=$logCmd" | wc -l | xargs echo Results: "
eval $commitCount
