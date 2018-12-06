#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   04.01.2016
#
# git push origin <current_branch_name>

branch_name=$(git branch | grep -oP '(?<=\* ).*')

git push origin $branch_name
