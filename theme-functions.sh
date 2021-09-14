#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Theme functions.

# ----------------------------------------------------------------------------------------------------------------------
# Get the notification area according to the parameter.
#
# param int 0: Poor notification area, no icons.
# param int 1: Rich notification area, icons instead of simples characters.
# return string Notification area.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_get_notification_area() {
    if [ "false" = "$1" ]
    then
        __fancygit_get_poor_notification_area
        return
    fi

    __fancygit_get_rich_notification_area
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a rich notification area, which means it will have the same icons as fancy themes.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_rich_notification_area() {
    local icon_git_stash=" "
    local icon_untracked_files="  "
    local icon_changed_files="  "
    local icon_added_files="  "
    local icon_unpushed_commits="  "
    local number_unpushed_commits=0
    local venv=""

    if [ "" = "$(fancygit_git_get_staged_files)" ]
    then
        icon_added_files=""
    fi

    if [ "" = "$(fancygit_git_get_stash)" ]
    then
        icon_git_stash=""
    fi

    if [ "" = "$(fancygit_git_get_untracked_files)" ]
    then
        icon_untracked_files=""
    fi

    if [ "" = "$(fancygit_git_get_changed_files)" ]
    then
        icon_changed_files=""
    fi

    number_unpushed_commits=$(fancygit_git_get_unpushed_commits | wc -l)
    icon_unpushed_commits="${icon_unpushed_commits}+${number_unpushed_commits}"
    if [ 0 -eq "$number_unpushed_commits" ]
    then
        icon_unpushed_commits=""
    fi

    venv=$(__fancygit_get_venv_icon)
    notification_area="${venv}${icon_git_stash}${icon_untracked_files}${icon_changed_files}${icon_added_files}${icon_unpushed_commits}"

    echo "$notification_area "
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a poor notification area, which means it won't have icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_poor_notification_area() {
    local notification_area=""

    # Set colors.
    local color_reset="\\[\\e[39m\\]"
    local color_cyan="\\[\\e[36m\\]"
    local color_light_green="\\[\\e[92m\\]"
    local color_light_red="\\[\\e[91m\\]"

    # Git info.
    local branch_name
    local staged_files
    local git_stash
    local git_has_unpushed_commits
    local git_number_unpushed_commits
    local git_number_untracked_files
    local git_number_changed_files

    # Set git info.
    branch_name=$(fancygit_git_get_branch)
    staged_files=$(fancygit_git_get_staged_files)
    git_stash=$(fancygit_git_get_stash)
    git_has_unpushed_commits=$(fancygit_git_get_unpushed_commits)
    git_number_unpushed_commits=$(fancygit_git_get_unpushed_commits | wc -l)
    git_number_untracked_files=$(fancygit_git_get_untracked_files | wc -l)
    git_number_changed_files=$(fancygit_git_get_changed_files | wc -l)

    if [ "" != "$git_stash" ]
    then
        notification_area="${notification_area}∿${color_reset} "
    fi

    if [ "$git_number_untracked_files" -gt 0 ]
    then
        notification_area="${notification_area}${color_cyan}?${color_reset} "
    fi

    if [ "$git_number_changed_files" -gt 0 ]
    then
        notification_area="${notification_area}${color_light_green}+${color_reset}${color_light_red}-${color_reset} "
    fi

    if [ "" != "$staged_files" ]
    then
        notification_area="${notification_area}${color_light_green}✔${color_reset} "
    fi

    if [ "$git_has_unpushed_commits" ]
    then
        notification_area="${notification_area}${color_light_green}^${git_number_unpushed_commits}${color_reset} "
    fi

    if [ "" != "$branch_name" ] && fancygit_git_is_only_local_branch "$branch_name"
    then
        notification_area="${notification_area}${color_light_green}*${color_reset} "
    fi

    if fancygit_git_is_merged_branch
    then
        notification_area="${notification_area}${color_light_green}<${color_reset} "
    fi

    if [ "" != "$notification_area" ]
    then
        # Trim notification_area content
        notification_area=$(echo "$notification_area" | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//')
        echo " [ $notification_area ] "
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the icon that indicates we're working in a virtual environment.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_venv_icon() {
    local icon_venv

    icon_venv=" "

    if ! [ -z $VIRTUAL_ENV ] || ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z $CONDA_DEFAULT_ENV ])
    then
        echo "$icon_venv"
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the virtual environment name if it exists.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_get_venv_name() {
    if ! [ -z ${VIRTUAL_ENV} ]
    then
        echo "($(basename \"$VIRTUAL_ENV\")) "
        return
    fi

    if ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        echo "($(basename \"$CONDA_DEFAULT_ENV\")) "
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the path sign.
# 
# return string Path sign.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_get_path_sign() {
    if fancygit_config_is "show_full_path" "true"
    then
        echo "\\w"
        return
    fi

    echo "\\W"
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the prompt time.
# 
# return string Formated time.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_get_time() {
    local time_format=""

    if fancygit_config_is "show_time" "true"
    then
        time_format=$(fancygit_config_get "time_format" "%H:%M:%S")
        echo "[$(date +"${time_format}")] "
        return
    fi

    echo ""
}

fancygit_theme_get_double_line() {
    if fancygit_config_is "double_line" "true"
    then
        echo "\n$(fancygit_config_get "ps2" "➜")"
    fi

    echo ""
}