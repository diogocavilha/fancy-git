#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.13.2017
#
# git add

git add "$*" && \
clear && \
git status
