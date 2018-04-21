#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     04.21.2018
#
# ADD, COMMIT, PUSH
#
# A shortcut for a common sequence in order to push changes

branch=$(git branch | grep -oP '(?<=\* ).*')
msg=$1

git add --all && \
git commit -m "$1" && \
git push origin $branch
