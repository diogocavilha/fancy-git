#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     07.05.2016
#
# BRANCH CHACKOUT
#
# It forces the checkout of a branch

branch_name=$1
git checkout --track origin/$branch_name
