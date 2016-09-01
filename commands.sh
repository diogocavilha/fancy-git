#!/bin/bash

VERSION="3.0"

fg_script_help()
{
    cat ~/.fancy-git/help
}

fg_show_version()
{
    echo "Fancy Git $VERSION"
    echo "Copyleft (ɔ) 2016 by Diogo Alexsander Cavilha."
    echo ""
}

fg_self_update()
{
    local current_dir=$(pwd)
    cd ~/.fancy-git/ && git pull
    . ~/.bashrc
    cd "$current_dir"
    echo ""
    echo " Fancy git is up-to-date."
    echo " Version: $VERSION"
    echo ""
}

fg_command_not_found()
{
    echo ""
    echo " $1: Command not found."
    fg_script_help
}

case $1 in
    "-h"|"--help") fg_script_help;;
    "-v"|"--version") fg_show_version;;
    "self-update") fg_self_update;;
    *) fg_command_not_found "$1";;
esac
