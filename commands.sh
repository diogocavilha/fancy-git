#!/bin/bash

fg_version="3.2"

fg_script_help() {
    cat ~/.fancy-git/help
}

fg_show_version() {
    echo "Fancy Git $fg_version"
    echo "Copyleft (ɔ) 2016 by Diogo Alexsander Cavilha. <diogocavilha@gmail.com>"
    echo ""
}

fg_self_update() {
    local current_dir
    current_dir=$(pwd)
    cd ~/.fancy-git/ && git pull
    . ~/.bashrc
    cd "$current_dir" || return
    echo ""
    echo " Fancy git is up-to-date."
    echo " Version: $fg_version"
    echo ""
}

fg_command_not_found() {
    echo ""
    echo " $1: Command not found."
    fg_script_help
}

fg_change_to_default_style()
{
    local current_dir
    current_dir=$(pwd)
    cd ~/.fancy-git/ && git checkout master
    . ~/.bashrc
    cd "$current_dir" || return
    echo ""
    echo " If you cannot see any changes yet, please restart the terminal."
    echo ""
}

case $1 in
    "-h"|"--help") fg_script_help;;
    "-v"|"--version") fg_show_version;;
    "self-update") fg_self_update;;
    "default") fg_change_to_default_style;;
    *) fg_command_not_found "$1";;
esac
