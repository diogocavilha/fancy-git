#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   12.05.2018

_fancygit_update_checker() {
    local current_date
    local last_update_at

    current_date=$(date +%Y-%m-%d)

    if [ ! -f ~/.fancy-git/last_update_at ]; then
        touch -f ~/.fancy-git/last_update_at
    fi

    last_update_at=$(cat ~/.fancy-git/last_update_at)

    if [ "$current_date" != "$last_update_at" ]; then
        fg_update_checker "no"
    fi
}
