#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   09.12.2021
#
# App manager - Core commands manager.

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
    echo "> Please, check FancyGit help in order to check possible commands."
    echo "> Type \"fancygit -h\"".
    echo ""
    echo "> You could also check last changes by typing \"fancygit --changelog-show\"."
    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Show a list of available color schemes.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_show_color_schemes() {
    local param_show_all="$1"
    local current_theme
    local color_schemes_path="${HOME}/.fancy-git/color_schemes"

    if [ "true" = "$param_show_all" ]
    then
        tput bold
        tput setaf 2
        printf "\nAll available color schemes:\n\n"
        tput sgr0

        printf "%s\n" $(ls ${color_schemes_path}/* | sed "s,${color_schemes_path}/.*_,--color-scheme-,")
        echo ""
        return
    fi

    current_theme=$(fancygit_config_get "theme" "default")

    tput bold
    tput setaf 2
    printf "\nAvailable color schemes for current theme (--theme-${current_theme}):\n\n"
    tput sgr0

    printf "%s\n" $(ls ${color_schemes_path}/${current_theme}_* | sed "s,${color_schemes_path}/${current_theme}_,--color-scheme-,")
    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Show a list of available themes.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_show_themes() {
    local themes_path="${HOME}/.fancy-git/themes"

    tput bold
    tput setaf 2
    printf "\nAll available themes:\n\n"
    tput sgr0

    printf "%s\n" $(ls ${themes_path}/* | sed "s,${themes_path}/*,--theme-," | sed 's/.sh//')
    echo ""
}