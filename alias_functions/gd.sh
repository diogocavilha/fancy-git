#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     11.28.2017
#
# GIT DIFF
#
# Show changes of a file and suggests to add it

clear

if [ "$1" = "" ]
then
    git diff
    return
fi

git diff "$1"

echo ""
read -p " Add this file to commit? [y/N]: " r

if [ "$r" = "y" ]
then
    git add "$1"
fi

clear
git status

