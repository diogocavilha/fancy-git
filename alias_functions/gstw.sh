#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     04.19.2018
#
# SHOW STASH CHANGES
#
# It shows a stash changes

stash_id=$1
git stash show stash@{$stash_id}
