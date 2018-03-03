#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date: 11.16.2017
#
# Fancygit installation script.

fg_os=$(uname)

# git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git
cp /home/rafael/dockerprojects/fancy-git/ ~/.fancy-git

if [ "$fg_os" = "Linux" ]
then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "" >> ~/.bashrc
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bashrc
fi

if [ "$fg_os" = "Darwin" ]
then
    cp -f ~/.bash_profile ~/.bash_profile.backup
    echo "" >> ~/.bash_profile
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bash_profile
fi

mkdir ~/.fonts
cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
fc-cache -fv
