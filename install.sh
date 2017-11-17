#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date: 11.16.2017
#
# Fancygit installation script.

git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git
cp -f ~/.bashrc ~/.bashrc.backup
echo "" >> .bashrc
echo ". ~/.fancy-git/main.sh" >> ~/.bashrc
. ~/.bashrc

