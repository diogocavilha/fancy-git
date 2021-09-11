#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.16.2017
#
# Fancygit installation script.

FANCYGIT_RUNNING_OS=$(uname)
FANCYGIT_GIT_PATH=$(whereis git | cut -d ":" -f 2)

if [ "$FANCYGIT_GIT_PATH" = "" ]; then
    echo ""
    echo " ⚠ Please install git before running this command."
    echo ""
    exit 0
fi

git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git

if [ "$FANCYGIT_RUNNING_OS" = "Linux" ]; then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "" >> ~/.bashrc
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bashrc

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config

    current_date=$(date +%Y-%m-%d)
    touch -f ~/.fancy-git/last_update_at
    echo "$current_date" > ~/.fancy-git/last_update_at
fi

if [ "$FANCYGIT_RUNNING_OS" = "Darwin" ]; then
    cp -f ~/.bash_profile ~/.bash_profile.backup
    echo "" >> ~/.bash_profile
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bash_profile

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config
fi

mkdir -p ~/.fonts
cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf ~/.fonts
cp -i ~/.fancy-git/fonts/JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf ~/.fonts
fc-cache -fv
