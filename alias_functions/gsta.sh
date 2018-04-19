#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     04.19.2018
#
# APPLY STASH
#
# It applies a stash

stash_id=$1
git stash apply stash@{$stash_id}
