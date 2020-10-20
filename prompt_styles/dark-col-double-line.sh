#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   12.02.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update

    local blue="\\033[95;38;5;45m"
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local light_green="\\[\\e[92m\\]"
    local light_yellow="\\[\\e[93m\\]"
    local none="\\[\\e[39m\\]"
    local dark_orange="\\033[95;38;5;166m"
    local orange="\\033[95;38;5;214m"

    # Prompt style
    user="${orange}${bg_dark_gray_01}${bold}"
    at="${white}${bg_dark_gray_01}${bold}"
    host="${light_yellow}${bg_dark_gray_01}${bold}"
    user_at_host_end="${bold_none}${bg_none}"
    user_at_host_end_git="${bold_none}${bg_none}"
    user_symbol="${bg_dark_gray}${bold}${white}"
    user_symbol_end="${none}${bold_none}${bg_none}${s_darkgray}"
    path="${bg_dark_gray}${white}${bold}"
    path_git="${bg_dark_gray_05}${dark_orange}  ${is_git_repo} ${bold}"
    path_end="${none}${bold_none}"
    branch="${s_darkgray05_bgdarkgray04}${bg_dark_gray_04}${white}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_darkgray04}"
    local venv=""
    local path_sign=""
    local user_at_host=""

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${s_darkgray05_bglightyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_lightyellow}"
    fi

    if [ "$staged_files" = "" ]
    then
        has_added_files=""
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${s_darkgray05_bglightgreen}${bg_light_green}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_green}"
    fi

    if [ "$git_stash" = "" ]
    then
        has_git_stash=""
    fi

    if [ "$git_untracked_files" = "" ]
    then
        has_untracked_files=""
    fi

    if [ "$git_changed_files" = "" ]
    then
        has_changed_files=""
    fi

    has_unpushed_commits="$has_unpushed_commits+$git_number_unpushed_commits"
    if [ "$git_has_unpushed_commits" = "" ]
    then
        has_unpushed_commits=""
    fi

    if fg_show_user_at_machine
    then
        user_at_host="${user}\\u${at}@${host}\\h "
        user_at_host_end="${bold_none}${bg_none}${s_darkgray01_bgdarkgray}"
        user_at_host_end_git="${bold_none}${bg_none}${s_darkgray01_bgdarkgray05}"
    fi

    if [ "$branch_name" != "" ]
    then
	   prompt_user="${user_at_host}${user_at_host_end_git}"
    else
	   prompt_user="${user_at_host}${user_at_host_end}"
    fi

    prompt_symbol="\n${user_symbol}\$${user_symbol_end}"

    if ! [ -z ${VIRTUAL_ENV} ] || ([ ${CONDA_DEFAULT_ENV} != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        venv="$working_on_venv"
    fi

    path_sign="\\W"
    if fg_show_full_path
    then
        path_sign="\\w"
    fi

    prompt_path="${path}${bold}${blue}${venv} $path_sign ${path_end}${s_darkgray}"

    if [ "$branch_name" != "" ]
    then
        branch_icon=$(fg_get_branch_icon)
        prompt_path="${path_git}${venv}${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files}${has_unpushed_commits} $path_sign ${path_end}"
        prompt_branch="${branch} ${branch_icon} ${branch_name} ${branch_end}"
        PS1="${prompt_user}${prompt_path}${prompt_branch}${prompt_symbol} "
        return
    fi

    PS1="${prompt_user}${prompt_path}${prompt_symbol} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
