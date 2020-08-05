#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.28.2017
#
# git diff

clear

if [ "$1" = "" ]; then
    git diff
    return
fi

git diff "$1"

echo ""
read -p " Add this file to commit? [y/N]: " r

if [ "$r" = "y" ]; then
    git add "$1"
    clear
    git status
    return
fi

read -p " Rollback this file changes? [y/N]: " r

if [ "$r" = "y" ]; then
    git checkout "$1"
fi

clear
git status
