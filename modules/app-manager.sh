#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Core commands manager.

# ----------------------------------------------------------------------------------------------------------------------
# Show the help text.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_show_help() {
    sh ~/.fancy-git/help.sh | less
}

# ----------------------------------------------------------------------------------------------------------------------
# Show app version.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_show_version() {
    echo " Fancy Git v$FANCYGIT_VERSION - $(date +%Y) by Diogo Alexsander Cavilha <diogocavilha@gmail.com>."
    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Show default error message when a command is not found.
# 
# param string $1 Command.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_not_found() {
    echo ""
    echo " $1: Command not found."
    fancygit_app_command_show_help
}

# ----------------------------------------------------------------------------------------------------------------------
# Install all the fonts compatible with FancyGit icons/symbols.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_install_fonts() {
    mkdir -p ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf ~/.fonts
    fc-cache -fv
}

# ----------------------------------------------------------------------------------------------------------------------
# Workaround when running on MAC OS.
# It seems MAC OS does not recognize the "return" key word.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_return() {
    local running_os
    running_os=$(uname)

    if [ "Linux" = "$running_os" ]
    then
        return
    fi
}

# ----------------------------------------------------------------------------------------------------------------------
# Show default error message when a command is deprecated.
#
# param string $1 New command to be used.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_app_command_deprecation_warning() {
    local param_new_command="$1"

    echo ""
    echo "> Woops! This command has been changed!"
    echo "> Plase type \"fancygit ${param_new_command}\" instead ;)"
    echo ""
}
