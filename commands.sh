#!/bin/bash

. ~/.fancy-git/version.sh

fg_script_help() {
    sh ~/.fancy-git/help.sh | less
}

fg_show_version() {
    local current_year
    current_year=$(date +%Y)
    echo " Fancy Git v$FANCYGIT_VERSION (c) $current_year by Diogo Alexsander Cavilha <diogocavilha@gmail.com>."
    echo ""
}

fg_update() {
    local current_dir
    local mode_file
    local base_path

    base_path="/home/$USER/.fancy-git"

    if [ ! -d "$base_path" ]; then
        styles_dir="/Users/$USER/.fancy-git"
    fi

    current_dir=$(pwd)
    mode_file="$base_path/mode"

    cd ~/.fancy-git/ && git pull

    if [ ! -f "$mode_file" ]; then
        touch -f "$mode_file"
        echo "default" > "$mode_file"
    fi

    cd "$current_dir" || return
    head -n 20 ~/.fancy-git/CHANGELOG.md
}

fg_command_not_found() {
    echo ""
    echo " $1: Command not found."
    fg_script_help
}

fg_change_mode() {
    echo "$1" > ~/.fancy-git/mode
    echo ""
    echo " If you cannot see any changes yet, please restart the terminal session."
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
    "simple") fg_change_mode "simple";;
    "default") fg_change_mode "default";;
    "double-line") fg_change_mode "fancy-double-line";;
    "simple-double-line") fg_change_mode "simple-double-line";;
    "human") fg_change_mode "human";;
    "dark") fg_change_mode "dark";;
    "dark-double-line") fg_change_mode "dark-double-line";;
    "light") fg_change_mode "light";;
    "light-double-line") fg_change_mode "light-double-line";;
    "configure-fonts") fg_install_fonts;;
    *) fg_command_not_found "$1";;
esac
