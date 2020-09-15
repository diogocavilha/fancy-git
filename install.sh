#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.16.2017
#
# Fancygit installation script.

fg_os=$(uname)

git_path=`whereis git | cut -d ":" -f 2`

if [ "$git_path" = "" ]; then
    echo ""
    echo " ⚠ Please install git before running this command."
    echo ""
    exit 0
fi

git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git

if [ "$fg_os" = "Linux" ]; then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "" >> ~/.bashrc
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bashrc

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config

    current_date=$(date +%Y-%m-%d)
    touch -f ~/.fancy-git/last_update_at
    echo "$current_date" > ~/.fancy-git/last_update_at
fi

if [ "$fg_os" = "Darwin" ]; then
    cp -f ~/.bash_profile ~/.bash_profile.backup
    echo "" >> ~/.bash_profile
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bash_profile

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config
fi

mkdir -p ~/.fonts
cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
fc-cache -fv
