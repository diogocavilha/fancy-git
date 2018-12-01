#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date: 11.27.2018

_fancygit_after_pulling_random_message() {
    local messages
    local option

    messages=(
        "Start to pray."
        "It works here."
        "Things are about to change."
        "If you use tests, don't worry. If you don't... Good luck!"
        "Keep calm, nothing has changed... too much... I think."
    )

    list_size=${#messages[@]}
    option=$((RANDOM % $list_size))

    echo ""
    echo "=> ${messages[$option]}"
    echo ""
}
