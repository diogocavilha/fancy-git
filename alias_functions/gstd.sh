#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     04.19.2018
#
# DROP STASH
#
# It drops a stash

stash_id=$1
git stash drop stash@{$stash_id}
