#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.16.2017
#
# Fancygit uninstaller.

fg_os=$(uname)

if [ "$fg_os" = "Linux" ]; then
    sed -i '/. ~\/.fancy-git\/prompt.sh/d' ~/.bashrc
fi

if [ "$fg_os" = "Darwin" ]; then
    sed -i '' '/. ~\/.fancy-git\/prompt.sh/d' ~/.bashrc
fi

rm -rf ~/.fancy-git

