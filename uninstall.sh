#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date: 11.16.2017
#
# Fancygit installer.

fg_uname=$(uname)

if [[ "$fg_uname" = "Linux" ]]; then
    sed -i '/. ~\/.fancy-git\/prompt.sh/d' ~/.bashrc
fi

if [[ "$fg_uname" = "Darwin" ]]; then
    sed -i '' '/. ~\/.fancy-git\/prompt.sh/d' ~/.bashrc
fi

rm -rf ~/.fancy-git

