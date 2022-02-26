#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   04.01.2016
#
# git pull origin <current_branch_name>

# shellcheck source=/dev/null
. ~/.fancy-git/random_messages.sh

run() {
    local branch_name
    branch_name=$(git branch | grep -oP '(?<=\* ).*')

    git pull origin "$branch_name"

    _fancygit_after_pulling_random_message
}
