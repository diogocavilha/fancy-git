#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Commands manager.

. ~/.fancy-git/modules/settings-manager.sh
. ~/.fancy-git/modules/update-manager.sh

__fancygit_command_show_help() {
    sh ~/.fancy-git/help.sh | less
}

__fancygit_command_show_version() {
    local current_year
    current_year=$(date +%Y)
    echo " Fancy Git v$FANCYGIT_VERSION - $current_year by Diogo Alexsander Cavilha <diogocavilha@gmail.com>."
    echo ""
}

__fancygit_command_not_found() {
    echo ""
    echo " $1: Command not found."
    __fancygit_command_show_help
}

__fancygit_command_install_fonts() {
    mkdir -p ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
    fc-cache -fv
}

__fancygit_command_show_suggested_colors() {
    echo "
git config --global color.ui true

git config --global color.diff.meta \"yellow bold\"
git config --global color.diff.old \"red bold\"
git config --global color.diff.new \"green bold\"
git config --global color.status.added \"green bold\"
git config --global color.status.changed \"yellow\"
git config --global color.status.untracked \"cyan\"
"
}

__fancygit_command_suggested_colors_apply() {
    `git config --global color.ui true`
    `git config --global color.diff.meta "yellow bold"`
    `git config --global color.diff.old "red bold"`
    `git config --global color.diff.new "green bold"`
    `git config --global color.status.added "green bold"`
    `git config --global color.status.changed "yellow"`
    `git config --global color.status.untracked "cyan"`
}

__fancygit_command_return() {
    local running_os
    running_os=$(uname)

    if [ "Linux" = "$running_os" ]
    then
        return
    fi
}

__fancygit_command_deprecation_warning() {
    local param_new_command="$1"

    echo ""
    echo "> Woops! This command has been changed!"
    echo "> Plase type \"fancygit ${param_new_command}\" instead ;)"
    echo ""
}

case "$1" in
    "-h"|"--help") __fancygit_command_show_help;;
    "-v"|"--version") __fancygit_command_show_version;;
    "--colors") __fancygit_command_show_suggested_colors;;
    "--colors-apply") __fancygit_command_suggested_colors_apply;;
    "--enable-full-path") fancygit_config_save "show-full-path" "true";;
    "--disable-full-path") fancygit_config_save "show-full-path" "false";;
    "--enable-show-user-at-machine") fancygit_config_save "show-user-at-machine" "true";;
    "--disable-show-user-at-machine") fancygit_config_save "show-user-at-machine" "false";;
    "--enable-time") fancygit_config_save "show-time" "true";;
    "--disable-time") fancygit_config_save "show-time" "false";;
    "--enable-double-line") fancygit_config_save "double-line" "true";;
    "--disable-double-line") fancygit_config_save "double-line" "false";;
    "--enable-rich-notification") fancygit_config_save "show-rich-notification" "true";;
    "--disable-rich-notification") fancygit_config_save "show-rich-notification" "false";;
    "--config-list") fancygit_config_show;;
    "--reset") fancygit_config_reset;;
    "--update") fancygit_update;;
    "simple") fancygit_config_save "style" "simple";;
    "default") fancygit_config_save "style" "default";;
    "human") fancygit_config_save "style" "human";;
    "dark") fancygit_config_save "style" "dark";;
    "dark-col") fancygit_config_save "style" "dark-col";;
    "light") fancygit_config_save "style" "light";;
    "dracula") fancygit_config_save "style" "dracula";;
    "--fonts-install") __fancygit_command_install_fonts;;
    "--separator-default") fancygit_config_save "separator" "";;
    "--separator-blocs") fancygit_config_save "separator" "";;
    "--separator-blocs-tiny") fancygit_config_save "separator" "";;
    "--separator-fire") fancygit_config_save "separator" "";;
    "--separator-lego") fancygit_config_save "separator" "";;
    "--separator-curve") fancygit_config_save "separator" "";;
    "--separator-paint") fancygit_config_save "separator" "";;

    # Deprecated commands
    "--config-reset") __fancygit_command_deprecation_warning "--reset";;
    "--colors-set") __fancygit_command_deprecation_warning "--colors-apply";;
    "--enable-show-time") __fancygit_command_deprecation_warning "--enable-time";;
    "--disable-show-time") __fancygit_command_deprecation_warning "--disable-time";;
    "update") __fancygit_command_deprecation_warning "--update";;
    "configure-fonts") __fancygit_command_deprecation_warning "--fonts-install";;
    "dark-col-double-line") __fancygit_command_deprecation_warning "dark-col";;
    "double-line") __fancygit_command_deprecation_warning "--enable-double-line";;
    "dark-double-line") __fancygit_command_deprecation_warning "--enable-double-line";;
    "light-double-line") __fancygit_command_deprecation_warning "--enable-double-line";;
    "human-single-line") __fancygit_command_deprecation_warning "human";;
    "human-dark") __fancygit_command_deprecation_warning "human";;
    "human-dark-single-line") __fancygit_command_deprecation_warning "human";;
    "simple-double-line") __fancygit_command_deprecation_warning "--enable-double-line";;
    "") __fancygit_command_return;;
    *) __fancygit_command_not_found "$1";;
esac
