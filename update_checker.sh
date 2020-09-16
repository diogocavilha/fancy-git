#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   12.05.2018

fancygit_update_checker() {
    local option
    local current_dir
    local current_version
    local new_version

    if ! __fancygit_is_git_repo || ! __fancygit_need_to_update
    then
        return
    fi

    current_dir=$(pwd)
    current_version=$(git tag | tail -1)

    cd ~/.fancy-git && git fetch -t 2> /dev/null
    
    new_version=$(git tag | tail -1)

    if [ "$current_version" != "$new_version" ]
    then
        echo -e "\n Hey! Fancy Git $(tput bold; tput setaf 2)$new_version$(tput sgr0) has been released!"
        echo " You're running Fancy Git $(tput bold; tput setaf 6)$current_version$(tput sgr0)"
        echo ""
        read -r -p " $(tput bold)Would you like to update it? [Y/n]: $(tput sgr0)" option
        echo ""

        case "$option" in
            "y"|"Y"|"") fancygit_update;;
        esac
    fi

    __fancygit_save_update_checkpoint
    
    cd "$current_dir" || return
}

fancygit_update() {
    local current_dir
    local current_date

    current_date=$(date +%Y-%m-%d)
    echo "$current_date" > ~/.fancy-git/last_update_at

    current_dir=$(pwd)

    cd ~/.fancy-git/ && git pull origin master

    __fancygit_create_app_config
    __fancygit_copy_style_from_mode_file_to_app_config
    __fancygit_safetly_remove_mode_file
    __fancygit_save_update_checkpoint
    __fancygit_remove_thread_update_checker

    cd "$current_dir" || return
    head -n 20 ~/.fancy-git/CHANGELOG.md
}

__fancygit_is_git_repo() {
    local branch_name

    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ "$branch_name" = "" ]
    then
        return 1
    fi

    return 0
}

__fancygit_need_to_update() {
    local current_date
    local last_update_at  

    last_update_at=$(cat ~/.fancy-git/last_update_at 2> /dev/null)
    current_date=$(date +%Y-%m-%d)

    if [ "$current_date" = "$last_update_at" ]
    then
        return 1
    fi

    return 0
}

__fancygit_create_app_config() {
    if [ ! -f ~/.fancy-git/app_config ]
    then
        touch -f ~/.fancy-git/app_config
        cat ~/.fancy-git/app_config_sample > ~/.fancy-git/app_config
    fi
}

__fancygit_copy_style_from_mode_file_to_app_config() {
    if [ -f ~/.fancy-git/mode -a -f ~/.fancy-git/app_config ]
    then
        local style=`cat ~/.fancy-git/mode`
        sed -i "s#style:.*#style:${style}#" ~/.fancy-git/app_config
    fi
}

__fancygit_safetly_remove_mode_file() {
    local app_config_file_status

    app_config_file_status=`grep -io 'fresh_file' < ~/.fancy-git/app_config`

    if [ "$app_config_file_status" = "fresh_file" ]
    then
        sed -i '/fresh_file/d' ~/.fancy-git/app_config
        rm -f mode
    fi
}

__fancygit_save_update_checkpoint() {
    current_date=$(date +%Y-%m-%d)
    echo "$current_date" > ~/.fancy-git/last_update_at
}
