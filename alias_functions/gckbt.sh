#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   07.05.2016
#
# git checkout --track origin/<current_branch_name>

branch_name="$1"
git checkout --track origin/$branch_name
