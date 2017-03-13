#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     03.13.2017
#
# ADDING FILES
#
# Adds files in order to commit and shows git status

git add $* && \
clear && \
git status
