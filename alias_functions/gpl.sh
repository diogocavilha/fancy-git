#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   04.01.2016
#
# git pull

# shellcheck source=/dev/null
. ~/.fancy-git/random_messages.sh

run() {
    git pull

    _fancygit_after_pulling_random_message
}
