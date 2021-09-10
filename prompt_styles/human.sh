#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update
    
    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, here you have the skin color config.
    # Once you wish to change some colors, the only thing you need to to is changing these *_foreground variable values.
    # It'll be handled in order to create the proper color on PS1 prompt.
    local time_foreground="231"
    local user_symbol_foreground="231"
    local workdir_foreground="10"
    local user_foreground="208"
    local host_foreground="220"
    local at_foreground="231"
    local branch_foreround="13"
    local branch_staged_files_foreground="13"
    local branch_changed_files_foreground="13"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local time_color_tag="\\[\\e[38;5;${time_foreground}m\\]"
    local user_color_font_tag="\\[\\e[38;5;${user_foreground}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${host_foreground}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${at_foreground}m\\]"
    local user_symbol_color_font_tag="\\[\\e[38;5;${user_symbol_foreground}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${workdir_foreground}m\\]"
    local branch_color_staged_files_font_tag="\\[\\e[38;5;${branch_staged_files_foreground}m\\]"
    local branch_color_changed_files_font_tag="\\[\\e[38;5;${branch_changed_files_foreground}m\\]"
    local branch_color_font_tag="\\[\\e[38;5;${branch_foreround}m\\]"
    local color_reset="\\[\\e[39m\\]"
    local bold="\\[\\e[1m\\]"
    local bold_reset="\\[\\e[0m\\]"
    local background_reset="\\[\\e[49m\\]"

    # Prompt style.
    local user="${user_color_font_tag}"
    local host="${host_color_font_tag}"
    local at="${at_color_font_tag}"
    local user_at_host_end="${background_reset}"
    local user_symbol="${user_symbol_color_font_tag}"
    local user_symbol_end="${color_reset}${background_reset}"
    local path="${workdir_color_font_tag}"
    local path_git="${workdir_color_font_tag}"
    local path_end="${color_reset}"
    local branch="${branch_color_font_tag}"
    local branch_end="${background_reset}${color_reset}"
    local time="${time_color_tag}"
    local time_end="${background_reset}"
    local venv=""
    local path_sign=""
    local prompt_user=""
    local prompt_time=""
    local fancygit_PS2=""
    local is_double_line=""
    local notification_area=""
    local branch_status=""

    # Get git repo info.
    branch_status=$(__get_git_status)
    staged_files=$(__get_git_diff)

    if [ "${branch_status}" != "" ]
    then
        branch="${branch_color_changed_files_font_tag}${bold}"
        branch_end="${background_reset}${color_reset}"
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${branch_color_staged_files_font_tag}"
        branch_end="${background_reset}${color_reset}"
    fi

    # Check some config preferences.
    if fancygit_config_is "double-line" "true"
    then
        fancygit_PS2=$(fancygit_config_get "ps2" "➜")
        is_double_line="\n${fancygit_PS2}"
    fi

    if fancygit_config_is "show-time" "true"
    then
      formatted_time=$(date +"${time_format}")
      prompt_time="${time}[${formatted_time}]${time_end} "
    fi

    if fancygit_config_is "show-user-at-machine" "true"
    then
        prompt_user="${user}\\u${color_reset}${at} at ${color_reset}${host}\\h${color_reset}${user_at_host_end} in "
    fi

    path_sign="\\W"
    if fancygit_config_is "show-full-path" "true"
    then
        path_sign="\\w"
    fi

    prompt_symbol="${user_symbol}\$${user_symbol_end}"

    if ! [ -z ${VIRTUAL_ENV} ] || ([ "${CONDA_DEFAULT_ENV}" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        venv="${working_on_venv}"
    fi

    prompt_path="${path}${venv}${path_sign}${path_end}${color_reset}"

    if [ "${branch_name}" != "" ]
    then
        prompt_path="${path_git}${path_sign}${path_end}"
        prompt_branch="${branch}${branch_name}${branch_end}"
        PS1="${bold}${prompt_time}${prompt_user}${prompt_path} on ${prompt_branch}$(__fancygit_notification_area 1)"
        PS1="${PS1}${prompt_symbol}${is_double_line}${bold_reset} "
        return
    fi

    PS1="${bold}${prompt_time}${prompt_user}${prompt_path} ${prompt_symbol}${is_double_line}${bold_reset} "
}

# ----------------------------------------------------------------------------------------------------------------------
# Get the notification area according to the parameter.
# 
# param int 0: Poor notification area, no icons.
# param int 1: Rich notification area, icons instead of simples characters.
# return string Notification area.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_notification_area() {
    if [ 0 -eq ${1} ]
    then
        echo " $(__fancygit_poor_notification_area) "
        return
    fi

    echo " $(__fancygit_rich_notification_area) "
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a rich notification area, which means it will have the same icons as fancy themes.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_rich_notification_area() {
    local notification_area=""
    local has_added_files=""
    local has_git_stash=""
    local has_untracked_files=""
    local has_changed_files=""
    local has_unpushed_commits=""

    has_git_stash=" "
    has_untracked_files="  "
    has_changed_files="  "
    has_added_files="  "
    has_unpushed_commits="  "
    working_on_venv=" "

    if [ "${staged_files}" = "" ]
    then
        has_added_files=""
    fi

    if [ "${git_stash}" = "" ]
    then
        has_git_stash=""
    fi

    if [ "${git_untracked_files}" = "" ]
    then
        has_untracked_files=""
    fi

    if [ "${git_changed_files}" = "" ]
    then
        has_changed_files=""
    fi

    has_unpushed_commits="${has_unpushed_commits}+${git_number_unpushed_commits}"
    if [ "${git_has_unpushed_commits}" = "" ]
    then
        has_unpushed_commits=""
    fi

    notification_area="${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files}${has_unpushed_commits}"

    echo "${notification_area}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a poor notification area, which means it won't have icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_poor_notification_area() {
    local notification_area=""
    local color_reset=""
    local color_cyan=""
    local color_light_green=""
    local color_light_red=""

    color_reset="\\[\\e[39m\\]"
    color_cyan="\\[\\e[36m\\]"
    color_light_green="\\[\\e[92m\\]"
    color_light_red="\\[\\e[91m\\]"

    # Git info
    local remote_name=""
    local remote_name=""
    local branch_name=""
    local staged_files=""
    local git_stash=""
    local git_untracked_files=""
    local git_changed_files=""
    local git_has_unpushed_commits=""
    local git_number_unpushed_commits=""
    local git_number_untracked_files=""
    local git_number_changed_files=""
    local merged_branch=""

    remote_name=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null | cut -d"/" -f1)
    remote_name=${remote_name:-origin}
    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    staged_files=$(__get_git_diff)
    git_stash=$(git stash list 2> /dev/null)
    git_untracked_files=$(git ls-files --others --exclude-standard 2> /dev/null)
    git_changed_files=$(git ls-files -m 2> /dev/null)
    git_has_unpushed_commits=$(git log ${remote_name}/${branch_name}..HEAD 2> /dev/null)
    git_number_unpushed_commits=$(git log --pretty=oneline ${remote_name}/${branch_name}..HEAD 2> /dev/null | wc -l)
    git_number_untracked_files=$(git ls-files --others --exclude-standard 2> /dev/null | wc -w)
    git_number_changed_files=$(git ls-files -m 2> /dev/null | wc -l)
    merged_branch=""

    if [ "$branch_name" != "master" ]; then
        merged_branch=$(git branch -r --merged master 2> /dev/null | grep ${branch_name} 2> /dev/null)
    fi

    if [ "${git_stash}" != "" ]
    then
        notification_area="${notification_area}∿${color_reset} "
    fi

    if [ "${git_number_untracked_files}" -gt 0 ]
    then
        notification_area="${notification_area}${color_cyan}?${color_reset} "
    fi

    if [ "${git_number_changed_files}" -gt 0 ]
    then
        notification_area="${notification_area}${color_light_green}+${color_reset}${color_light_red}-${color_reset} "
    fi

    if [ "${staged_files}" != "" ]
    then
        notification_area="${notification_area}${color_light_green}✔${color_reset} "
    fi

    if [ "${git_has_unpushed_commits}" ]
    then
        notification_area="${notification_area}${color_light_green}^${git_number_unpushed_commits}${color_reset} "
    fi

    if [ "${branch_name}" != "" ] && __fancygit_is_only_local_branch "${branch_name}"
    then
        notification_area="${notification_area}${color_light_green}*${color_reset} "
    fi

    if [ "${merged_branch}" != "" ]
    then
        notification_area="${notification_area}${color_light_green}<${color_reset} "
    fi

    if [ "${notification_area}" != "" ]
    then
        # Trim notification_area content
        notification_area=$(echo "${notification_area}" | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//')
        echo "[${notification_area}]"
        return
    fi

    echo ""
}

# Git commands.
# Some git commands are used in many parts of the code, that's why we have written some of them into a function.

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git status and return the output.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_status() {
    git status -s 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git diff and return the output.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_diff() {
    git diff --name-only --cached 2> /dev/null
}

PROMPT_COMMAND="fancygit_prompt_builder"
