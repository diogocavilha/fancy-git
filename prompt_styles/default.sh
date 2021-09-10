#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.08.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh
. ~/.fancy-git/modules/settings-manager.sh

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, here you have the skin color config.
    # Once you wish to change some colors, the only thing you need to do is changing these *_foreground variable values.
    # It'll be handled in order to create the proper color on PS1 prompt.
    local time_background="59"
    local time_foreground="231"
    local user_symbol_background="139"
    local user_symbol_foreground="231"
    local workdir_background="25"
    local workdir_foreground="231"
    local user_at_host_background="59"
    local user_foreground="231"
    local host_foreground="231"
    local at_foreground="231"
    local branch_background="231"
    local branch_foreround="0"
    local branch_staged_files_background="10"
    local branch_staged_files_foreground="0"
    local branch_changed_files_background="11"
    local branch_changed_files_foreground="0"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local time_color_bg_tag="\\[\\e[48;5;${time_background}m\\]"
    local time_color_tag="\\[\\e[38;5;${time_foreground}m\\]"
    local user_color_font_tag="\\[\\e[38;5;${user_foreground}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${host_foreground}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${at_foreground}m\\]"
    local user_symbol_color_tag="\\[\\e[38;5;${user_symbol_background}m\\]"
    local user_symbol_color_bg_tag="\\[\\e[48;5;${user_symbol_background}m\\]"
    local user_symbol_color_font_tag="\\[\\e[38;5;${user_symbol_foreground}m\\]"
    local workdir_color_tag="\\[\\e[38;5;${workdir_background}m\\]"
    local workdir_color_bg_tag="\\[\\e[48;5;${workdir_background}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${workdir_foreground}m\\]"
    local user_at_host_color_tag="\\[\\e[38;5;${user_at_host_background}m\\]"
    local user_at_host_color_bg_tag="\\[\\e[48;5;${user_at_host_background}m\\]"
    local branch_color_staged_files_tag="\\[\\e[38;5;${branch_staged_files_background}m\\]"
    local branch_color_staged_files_bg_tag="\\[\\e[48;5;${branch_staged_files_background}m\\]"
    local branch_color_staged_files_font_tag="\\[\\e[38;5;${branch_staged_files_foreground}m\\]"
    local branch_color_changed_files_tag="\\[\\e[38;5;${branch_changed_files_background}m\\]"
    local branch_color_changed_files_bg_tag="\\[\\e[48;5;${branch_changed_files_background}m\\]"
    local branch_color_changed_files_font_tag="\\[\\e[38;5;${branch_changed_files_foreground}m\\]"
    local branch_color_tag="\\[\\e[38;5;${branch_background}m\\]"
    local branch_color_bg_tag="\\[\\e[48;5;${branch_background}m\\]"
    local branch_color_font_tag="\\[\\e[38;5;${branch_foreround}m\\]"
    local none="\\[\\e[39m\\]"
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local bg_none="\\[\\e[49m\\]"

    # Prompt style
    separator=$(fancygit_config_get "separator" "")
    is_git_repo=""
    local user="${bold}${user_color_font_tag}"
    local host="${bold}${host_color_font_tag}"
    local at="${bold}${at_color_font_tag}"
    local user_at_host="${bold}${user_at_host_color_bg_tag}"
    local user_at_host_end="${bold_none}${bg_none}${user_at_host_color_tag}${user_symbol_color_bg_tag}${separator}"
    local user_symbol="${user_symbol_color_bg_tag}${bold}${user_symbol_color_font_tag}"
    local user_symbol_end="${none}${bold_none}${bg_none}${user_symbol_color_tag}${workdir_color_bg_tag}${separator}"
    local path="${workdir_color_bg_tag}${workdir_color_font_tag}${bold}"
    local path_git="${workdir_color_bg_tag}${workdir_color_font_tag} ${is_git_repo} ${bold}"
    local path_end="${none}${bold_none}"
    local branch="${workdir_color_tag}${branch_color_bg_tag}${separator}${branch_color_font_tag}${bold}"
    local branch_end="${branch_color_tag}${bg_none}${separator}${bold_none}${none}"
    local time="${time_color_bg_tag}${time_color_tag}${bold}"
    local time_end="${bold_none}${bg_none}"
    local venv=""
    local path_sign=""
    local prompt_user=""
    local double_line_config=""
    local time_format=""
    local prompt_time=""

    # Read some config settings.
    if fancygit_config_is "double-line" "true"
    then
        double_line_config="\n$(fancygit_config_get "ps2" "➜")"
    fi

    if fancygit_config_is "show-time" "true"
    then
        time_format=$(fancygit_config_get "time-format" "%H:%M:%S")
        prompt_time="${time}[$(date +"${time_format}")] ${time_end}"
    fi

    if fancygit_config_is "show-user-at-machine" "true"
    then
        prompt_user="${user_at_host}${user}\\u${none}${at}@${none}${host}\\h${none} ${user_at_host_end}"
    fi

    path_sign="\\W"
    if fancygit_config_is "show-full-path" "true"
    then
        path_sign="\\w"
    fi

    # Building prompt

    # Configure a specific background color to branch name, if it has some change.
    if [ "" != "$(__get_git_status)" ]
    then
        branch="${workdir_color_tag}${branch_color_changed_files_bg_tag}${separator}${branch_color_changed_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_changed_files_tag}${separator}${none}"
    fi

    # Configure a specific background color to branch name, if it has staged files.
    if [ "" != "$(__get_git_staged_files)" ]
    then
        branch="${workdir_color_tag}${branch_color_staged_files_bg_tag}${separator}${branch_color_staged_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_staged_files_tag}${separator}${none}"
    fi

    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"
    prompt_path="${path}${bold}${venv} $path_sign ${path_end}${workdir_color_tag}${separator}${none}"

    # If we have a branch name, it means we are in a git repo, so we need to make some changes on PS1.
    branch_name=$(__get_git_branch)
    if [ "" != "${branch_name}" ]
    then
        prompt_path="${path_git}${venv}$(__fancygit_get_notification_area 1) $path_sign ${path_end}"
        prompt_branch="${branch} $(__fancygit_get_branch_icon "${branch_name}") ${branch_name} ${branch_end}"
        PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch}${double_line_config} "
        return
    fi

    PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${double_line_config} "
}

# ----------------------------------------------------------------------------------------------------------------------
# Checks if the given branch name is local only.
#
# param string $1 Branch name.
#
# return int 0: The given branch name is local only.
# return int 1: The given branch name is local and remote.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_is_only_local_branch() {
    local is_only_local_branch=""
    local branch_name=""

    branch_name="${1}"
    is_only_local_branch=$(git branch -r 2> /dev/null | grep -c "${branch_name}")

    if [ 0 -eq "${is_only_local_branch}" ]; then
        return 0
    fi

    return 1
}

# ----------------------------------------------------------------------------------------------------------------------
# Returns the branch icon according to the given branch name.
# It returns different icons for a local only branch and a local/remote one.
#
# param string $1 Branch name.
#
# return string Branch icon.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_branch_icon() {
    local branch_name
    local icon_local_branch
    local icon_local_remote_branch
    local icon_merged_branch

    branch_name="${1}"
    icon_local_branch=""
    icon_local_remote_branch=""
    icon_merged_branch=""

    if __fancygit_is_only_local_branch "${branch_name}"
    then
        echo "${icon_local_branch}"
        return
    fi

    if __is_merged_branch
    then
        echo "${icon_merged_branch}"
        return
    fi

    echo "${icon_local_remote_branch}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Get the notification area according to the parameter.
#
# param int 0: Poor notification area, no icons.
# param int 1: Rich notification area, icons instead of simples characters.
# return string Notification area.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_notification_area() {
    if [ 0 -eq "${1}" ]
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
    local notification_area
    local icon_git_stash
    local icon_untracked_files
    local icon_changed_files
    local icon_added_files
    local icon_unpushed_commits
    local icon_venv
    local venv
    local number_unpushed_commits

    icon_git_stash=" "
    icon_untracked_files="  "
    icon_changed_files="  "
    icon_added_files="  "
    icon_unpushed_commits="  "
    icon_venv=" "
    venv=""
    number_unpushed_commits=0

    if [ "" = "$(__get_git_staged_files)" ]
    then
        icon_added_files=""
    fi

    if [ "" = "$(__get_git_stash)" ]
    then
        icon_git_stash=""
    fi

    if [ "" = "$(__get_git_untracked_files)" ]
    then
        icon_untracked_files=""
    fi

    if [ "" = "$(__get_git_changed_files)" ]
    then
        icon_changed_files=""
    fi

    number_unpushed_commits=$(__get_git_unpushed_commits | wc -l)
    icon_unpushed_commits="${icon_unpushed_commits}+${number_unpushed_commits}"
    if [ 0 -eq "${number_unpushed_commits}" ]
    then
        icon_unpushed_commits=""
    fi

    if ! [ -z ${VIRTUAL_ENV} ] || ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        venv="${icon_venv}"
    fi

    notification_area="${venv}${icon_git_stash}${icon_untracked_files}${icon_changed_files}${icon_added_files}${icon_unpushed_commits}"

    echo "${notification_area}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a poor notification area, which means it won't have icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_poor_notification_area() {
    local notification_area
    local color_reset
    local color_cyan
    local color_light_green
    local color_light_red

    # Git info.
    local branch_name
    local staged_files
    local git_stash
    local git_has_unpushed_commits
    local git_number_unpushed_commits
    local git_number_untracked_files
    local git_number_changed_files

    # Set colors.
    color_reset="\\[\\e[39m\\]"
    color_cyan="\\[\\e[36m\\]"
    color_light_green="\\[\\e[92m\\]"
    color_light_red="\\[\\e[91m\\]"

    # Set git info.
    branch_name=$(__get_git_branch)
    staged_files=$(__get_git_staged_files)
    git_stash=$(__get_git_stash)
    git_has_unpushed_commits=$(__get_git_unpushed_commits)
    git_number_unpushed_commits=$(__get_git_unpushed_commits | wc -l)
    git_number_untracked_files=$(__get_git_untracked_files | wc -l)
    git_number_changed_files=$(__get_git_changed_files | wc -l)

    notification_area=""

    if [ "" != "${git_stash}" ]
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

    if [ "" != "${staged_files}" ]
    then
        notification_area="${notification_area}${color_light_green}✔${color_reset} "
    fi

    if [ "${git_has_unpushed_commits}" ]
    then
        notification_area="${notification_area}${color_light_green}^${git_number_unpushed_commits}${color_reset} "
    fi

    if [ "" != "${branch_name}" ] && __fancygit_is_only_local_branch "${branch_name}"
    then
        notification_area="${notification_area}${color_light_green}*${color_reset} "
    fi

    if __is_merged_branch
    then
        notification_area="${notification_area}${color_light_green}<${color_reset} "
    fi

    if [ "" != "${notification_area}" ]
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
# Checks if the current branch is has been merged already.

# return int 0 Branch has been merged.
# return int 1 Branch has not been merged.
# ----------------------------------------------------------------------------------------------------------------------
__is_merged_branch() {
    local branch
    local merged_branch

    merged_branch=""
    branch=$(__get_git_branch)

    # We don't need to check if branch is merged when it is one of: master, develop, main.
    # Since we assume they could be already the "main branch".
    # It might cause some trouble when we have a develop branch which is not the main one.
    case "${branch}" in
        "master"|"develop"|"main") return 1;;
    esac

    merged_branch=$(git branch -r --merged master 2> /dev/null | grep "${branch}" 2> /dev/null)
    if [ "" != "${merged_branch}" ]
    then
        return 0
    fi

    merged_branch=$(git branch -r --merged develop 2> /dev/null | grep "${branch}" 2> /dev/null)
    if [ "" != "${merged_branch}" ]
    then
        return 0
    fi

    merged_branch=$(git branch -r --merged main 2> /dev/null | grep "${branch}" 2> /dev/null)
    if [ "" != "${merged_branch}" ]
    then
        return 0
    fi

    return 1
}

# ----------------------------------------------------------------------------------------------------------------------
# Get git status.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_status() {
    git status -s 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git diff to check staged files and return the output.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_staged_files() {
    git diff --name-only --cached 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get current branch name.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get a list of stashes.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_stash() {
    git stash list 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get untracked files.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_untracked_files() {
    git ls-files --others --exclude-standard 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get a list of changed files.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_changed_files() {
    git ls-files -m 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get remote branch name.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_remote_name() {
    remote_name=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null | cut -d"/" -f1)
    remote_name=${remote_name:-origin}
    echo "${remote_name}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git ls-files to check changed files and return the output.
# ----------------------------------------------------------------------------------------------------------------------
__get_git_unpushed_commits() {
    branch_name=$(__get_git_branch)
    remote_name=$(__get_git_remote_name)
    git log --pretty=oneline "${remote_name}"/"${branch_name}"..HEAD 2> /dev/null
}

# Here's where the magic happens!
# It calls our main function (fancygit_prompt_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_prompt_builder"
