#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     03.16.2017
#
# CHECKOUT FILES
#
# Checkout files and shows git status

git checkout -- $* && \
clear && \
git status
