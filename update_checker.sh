#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date: 12.05.2018

_fancygit_update_checker() {
    local current_day

    current_day=`date +%d`
    if [ `echo "$current_day % 2" | bc` -eq 1 ]
    then
        fg_update_checker "no"
    fi
}
