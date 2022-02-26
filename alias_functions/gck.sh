#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.16.2017
#
# git checkout --

git checkout -- "$*" && \
clear && \
git status
