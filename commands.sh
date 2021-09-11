#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Commands manager.

. ~/.fancy-git/modules/settings-manager.sh
. ~/.fancy-git/modules/update-manager.sh
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

fancygit_install_fonts() {
    mkdir -p ~/.fonts
    cp -i ~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts
    cp -i ~/.fancy-git/fonts/Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf ~/.fonts
    fc-cache -fv
}

fancygit_show_suggested_colors() {
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

fancygit_suggested_colors_apply() {
    `git config --global color.ui true`
    `git config --global color.diff.meta "yellow bold"`
    `git config --global color.diff.old "red bold"`
    `git config --global color.diff.new "green bold"`
    `git config --global color.status.added "green bold"`
    `git config --global color.status.changed "yellow"`
    `git config --global color.status.untracked "cyan"`
}

fg_is_only_local_branch() {
    local only_local_branch=$(git branch -r 2> /dev/null | grep "${branch_name}" | wc -l)

    if [ "$only_local_branch" == 0 ]; then
        return 0
    fi

    return 1
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

fancygit_command_deprecation_warning() {
    local new_command

    new_command="${1}"

    echo ""
    echo "> Woops! This command has been changed!"
    echo "> Plase type \"fancygit ${new_command}\" instead ;)"
    echo ""
}

case "$1" in
    "-h"|"--help") fg_script_help;;
    "-v"|"--version") fg_show_version;;
    "--colors") fancygit_show_suggested_colors;;
    "--colors-apply") fancygit_suggested_colors_apply;;
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
    "simple-double-line") fancygit_config_save "style" "simple-double-line";;
    "human") fancygit_config_save "style" "human";;
    "dark") fancygit_config_save "style" "dark";;
    "dark-col") fancygit_config_save "style" "dark-col";;
    "light") fancygit_config_save "style" "light";;
    "dracula") fancygit_config_save "style" "dracula";;
    "--fonts-install") fancygit_install_fonts;;
    "--separator-default") fancygit_config_save "separator" "";;
    "--separator-blocs") fancygit_config_save "separator" "";;
    "--separator-blocs-tiny") fancygit_config_save "separator" "";;
    "--separator-fire") fancygit_config_save "separator" "";;
    "--separator-lego") fancygit_config_save "separator" "";;
    "--separator-curve") fancygit_config_save "separator" "";;
    "--separator-paint") fancygit_config_save "separator" "";;
    
    # Deprecated commands
    "--config-reset") fancygit_command_deprecation_warning "--reset";;
    "--colors-set") fancygit_command_deprecation_warning "--colors-apply";;
    "--enable-show-time") fancygit_command_deprecation_warning "--enable-time";;
    "--disable-show-time") fancygit_command_deprecation_warning "--disable-time";;
    "update") fancygit_command_deprecation_warning "--update";;
    "configure-fonts") fancygit_command_deprecation_warning "--fonts-install";;
    "dark-col-double-line") fancygit_command_deprecation_warning "dark-col";;
    "double-line") fancygit_command_deprecation_warning "--enable-double-line";;
    "dark-double-line") fancygit_command_deprecation_warning "--enable-double-line";;
    "light-double-line") fancygit_command_deprecation_warning "--enable-double-line";;
    "human-single-line") fancygit_command_deprecation_warning "human";;
    "human-dark") fancygit_command_deprecation_warning "human";;
    "human-dark-single-line") fancygit_command_deprecation_warning "human";;
    "") fg_return;;
    *) fg_command_not_found "$1";;
esac
