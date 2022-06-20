#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.16.2017
#
# Fancygit installation script.

FANCYGIT_RUNNING_OS=$(uname)
FANCYGIT_GIT_PATH=$(whereis git | cut -d ":" -f 2)
FANCYGIT_FONTCONFIG_PATH=$(dpkg-query -l fontconfig 2>&1)   #redirect STDERR to STDOUT to capture output

errcho() {
    >&2 echo "$@";
}

if [ "" = "$FANCYGIT_GIT_PATH" ]; then
    errcho ""
    errcho " ⚠ Please install git before running this command."
    errcho ""
    exit 0
fi

if [ "--nofontconfig" = "$1" ]; then
    echo "--nofontconfig selected: skipping fontconfig check"
else
    if [ "dpkg-query: no packages found matching fontconfig" = "$FANCYGIT_FONTCONFIG_PATH" ]; then
        errcho ""
        errcho " ⚠ Please either install fontconfig before running this command"
        errcho "   or use the --nofontconfig option to install fancygit"
        errcho "   without fontconfig present - e.g., if only using SSH"
        errcho ""
        exit 0
    fi
fi

git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git

if [ "Linux" = "$FANCYGIT_RUNNING_OS" ]; then
    cp -f ~/.bashrc ~/.bashrc.backup
    echo "" >> ~/.bashrc
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bashrc

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config

    current_date=$(date +%Y-%m-%d)
    touch -f ~/.fancy-git/last_update_at
    echo "$current_date" > ~/.fancy-git/last_update_at
fi

if [ "Darwin" = "$FANCYGIT_RUNNING_OS" ]; then
    cp -f ~/.bash_profile ~/.bash_profile.backup
    echo "" >> ~/.bash_profile
    echo ". ~/.fancy-git/prompt.sh" >> ~/.bash_profile

    touch -f ~/.fancy-git/app_config
    cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config
fi

if [ "--nofontconfig" = "$1" ]; then
    echo "--nofontconfig selected: skipping font installation"
else
    mkdir -p ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf ~/.fonts
    fc-cache -fv
fi