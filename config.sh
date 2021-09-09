#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.06.2018
#
# Configuration file.

. ~/.fancy-git/modules/config-manager.sh

# include config-override.inc
if [ -e ~/.fancy-git/config-override.sh ]; then
    . ~/.fancy-git/config-override.sh
fi

