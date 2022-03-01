#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.28.2017
#
# git diff

# It's more like a return command. This is a Mac OS issue.
fg_return() {
    exit
}

clear

if [ "$1" = "" ]; then
    git diff
    fg_return
fi

git diff "$1"

echo ""
read -rp " Add this file to commit? [y/N]: " r

if [ "$r" = "y" ]; then
    git add "$1"
    clear
    git status
    fg_return
fi

read -rp " Rollback this file changes? [y/N]: " r

if [ "$r" = "y" ]; then
    git checkout "$1"
fi

clear
git status
