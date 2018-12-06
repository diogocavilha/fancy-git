#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   04.01.2016
#
# git pull origin <branch_name>

. ~/.fancy-git/random_messages.sh

run() {
    local branch_name
    branch_name="$1"

    git pull origin $branch_name

    _fancygit_after_pulling_random_message
}
