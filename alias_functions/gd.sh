#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.28.2017
#
# git diff

# shellcheck source=/dev/null
. ~/.fancy-git/modules/settings-manager.sh
git_use_clear=$(fancygit_config_get "git_use_clear" "true")

clear_if_enabled () {
    if [ "$git_use_clear" = "true" ]; then
      clear
    fi
}

# It's more like a return command. This is a Mac OS issue.
fg_return() {
    exit
}

clear_if_enabled

if [ "$1" = "" ]; then
    git diff
    fg_return
fi

git diff "$1"

echo ""
read -rp " Add this file to commit? [y/N]: " r

if [ "$r" = "y" ]; then
    git add "$1"
    clear_if_enabled
    git status
    fg_return
fi

read -rp " Rollback this file changes? [y/N]: " r

if [ "$r" = "y" ]; then
    git checkout "$1"
fi

clear_if_enabled
git status
