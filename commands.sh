#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Commands manager.

. ~/.fancy-git/update_checker.sh
. ~/.fancy-git/version.sh

fg_script_help() {
    sh ~/.fancy-git/help.sh | less
}

fg_show_version() {
    local current_year
    current_year=$(date +%Y)
    echo " Fancy Git v$FANCYGIT_VERSION - $current_year by Diogo Alexsander Cavilha <diogocavilha@gmail.com>."
    echo ""
}

fg_command_not_found() {
    echo ""
    echo " $1: Command not found."
    fg_script_help
}

fg_install_fonts() {
    mkdir -p ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
    fc-cache -fv
}

fg_show_colors_config() {
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

fg_colors_config_set() {
    `git config --global color.ui true`
    `git config --global color.diff.meta "yellow bold"`
    `git config --global color.diff.old "red bold"`
    `git config --global color.diff.new "green bold"`
    `git config --global color.status.added "green bold"`
    `git config --global color.status.changed "yellow"`
    `git config --global color.status.untracked "cyan"`
}

fg_update_app_config() {
    fg_create_config_if_not_exists "${1}:"
    sed -i "s/${1}:.*/${1}:${2}/" ~/.fancy-git/app_config
}

fg_create_config_if_not_exists() {
    local config_content=""

    config_content=$(grep -o "${1}" < ~/.fancy-git/app_config)

    if [ "$config_content" = "" ]; then
        echo "${1}false" >> ~/.fancy-git/app_config
    fi
}

fg_show_app_config() {
    cat ~/.fancy-git/app_config
}

fg_show_full_path() {
    local config_content=""

    config_content=$(grep -o 'show-full-path:false' < ~/.fancy-git/app_config)

    if [ "$config_content" = "show-full-path:false" ]; then
        return 1
    fi

    return 0
}

fg_show_user_at_machine() {
    local config_content=""

    config_content=$(grep -o 'show-user-at-machine:false' < ~/.fancy-git/app_config)

    if [ "$config_content" = "show-user-at-machine:false" ]; then
        return 1
    fi

    return 0
}

fg_reset_app_config() {
    rm -f ~/.fancy-git/app_config
    _fg_create_app_config
    sed -i '/fresh_file/d' ~/.fancy-git/app_config
}

fg_is_only_local_branch() {
    local only_local_branch=$(git branch -r 2> /dev/null | grep "${branch_name}" | wc -l)

    if [ "$only_local_branch" == 0 ]; then
        return 0
    fi

    return 1
}

fg_get_branch_icon() {
    if fg_is_only_local_branch
    then
        echo "${is_only_local_branch}"
        return
    fi

    if [ "$merged_branch" != "" ]; then
        echo "${is_merged_branch}"
        return
    fi

    echo "${branch_icon}"
}

fg_branch_status() {
    . ~/.fancy-git/config.sh

    local info=""

    if [ "$git_stash" != "" ]
    then
        info="${info}∿${none} "
    fi

    if [ "$git_number_untracked_files" -gt 0 ]
    then
        info="${info}${cyan}?${none} "
    fi

    if [ "$git_number_changed_files" -gt 0 ]
    then
        info="${info}${light_green}+${none}${light_red}-${none} "
    fi

    if [ "$staged_files" != "" ]
    then
        info="${info}${light_green}✔${none} "
    fi

    if [ "$git_has_unpushed_commits" ]
    then
        info="${info}${light_green}^${git_number_unpushed_commits}${none} "
    fi

    if [ "$branch_name" != "" ] && fg_is_only_local_branch
    then
        info="${info}${light_green}*${none} "
    fi

    if [ "$merged_branch" != "" ]; then
        info="${info}${light_green}<${none} "
    fi

    if [ "$info" != "" ]; then
        info=$(echo "$info" | sed -e 's/[[:space:]]*$//')
        if [ "$1" == 1 ]; then
            echo " [$info]"
            return
        fi

        echo " $info"
        return
    fi

    echo ""
}

fg_return() {
    local fg_os
    fg_os=$(uname)

    if [ "$fg_os" = "Linux" ]; then
        return
    fi
}

case "$1" in
    "-h"|"--help") fg_script_help;;
    "-v"|"--version") fg_show_version;;
    "--colors") fg_show_colors_config;;
    "--colors-set") fg_colors_config_set;;
    "--enable-full-path") fg_update_app_config "show-full-path" "true";;
    "--disable-full-path") fg_update_app_config "show-full-path" "false";;
    "--enable-show-user-at-machine") fg_update_app_config "show-user-at-machine" "true";;
    "--disable-show-user-at-machine") fg_update_app_config "show-user-at-machine" "false";;
    "--config-list") fg_show_app_config;;
    "--config-reset") fg_reset_app_config;;
    "update") fancygit_update;;
    "simple") fg_update_app_config "style" "simple";;
    "default") fg_update_app_config "style" "default";;
    "double-line") fg_update_app_config "style" "fancy-double-line";;
    "simple-double-line") fg_update_app_config "style" "simple-double-line";;
    "human") fg_update_app_config "style" "human";;
    "human-single-line") fg_update_app_config "style" "human-single-line";;
    "human-dark") fg_update_app_config "style" "human-dark";;
    "human-dark-single-line") fg_update_app_config "style" "human-dark-single-line";;
    "dark") fg_update_app_config "style" "dark";;
    "dark-double-line") fg_update_app_config "style" "dark-double-line";;
    "dark-col-double-line") fg_update_app_config "style" "dark-col-double-line";;
    "light") fg_update_app_config "style" "light";;
    "light-double-line") fg_update_app_config "style" "light-double-line";;
    "configure-fonts") fg_install_fonts;;
    "") fg_return;;
    *) fg_command_not_found "$1";;
esac
