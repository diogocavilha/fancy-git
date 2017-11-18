#!/bin/bash

. ~/.fancy-git/version.sh

fg_script_help() {
    sh ~/.fancy-git/help.sh | less
}

fg_show_version() {
    echo " Fancy Git v$FANCYGIT_VERSION"
    echo " Copyleft (ɔ) 2016 by Diogo Alexsander Cavilha. <diogocavilha@gmail.com>"
    echo ""
}

fg_update() {
    local current_dir
    current_dir=$(pwd)
    cd ~/.fancy-git/ && git pull
    cd "$current_dir" || return
    cat ~/.fancy-git/CHANGELOG.md
}

fg_command_not_found() {
    echo ""
    echo " $1: Command not found."
    fg_script_help
}

fg_change_to_simple_style()
{
    local current_dir
    current_dir=$(pwd)
    cd ~/.fancy-git/ && git checkout simple
    cd "$current_dir" || return
    echo ""
    echo " If you cannot see any changes yet, please restart the terminal."
    echo ""
}

fg_change_to_default_style()
{
    local current_dir
    current_dir=$(pwd)
    cd ~/.fancy-git/ && git checkout master
    cd "$current_dir" || return
    echo ""
    echo " If you cannot see any changes yet, please restart the terminal."
    echo ""
}

fg_install_fonts() {
    mkdir ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    fc-cache -fv
}

case $1 in
    "-h"|"--help") fg_script_help;;
    "-v"|"--version") fg_show_version;;
    "update") fg_update;;
    "simple") fg_change_to_simple_style;;
    "default") fg_change_to_default_style;;
    "configure-fonts") fg_install_fonts;;
    *) fg_command_not_found "$1";;
esac
