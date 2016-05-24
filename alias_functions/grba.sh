#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     05.24.2016
#
# BRANCH RENAMING
#
# Rename branch locally
# Delete the old branch
# Push the new branch, set local branch to track the new remote

new_branch_name=$1
old_branch_name=$(git branch | grep -oP '(?<=\* ).*')

git branch -m $new_branch_name
git push origin :$old_branch_name
git push origin $new_branch_name
