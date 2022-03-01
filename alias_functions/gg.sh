#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   04.21.2018
#
# git add --all
# git commit -m <message>
# git push origin <current_branch_name>

branch_name=$(git branch | grep -oP '(?<=\* ).*')
msg="$1"

git add --all && \
git commit -m "$msg" && \
git push origin "$branch_name"
