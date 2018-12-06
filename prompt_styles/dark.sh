#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   12.01.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    # Prompt style
    user_at_host="${white}${bg_dark_gray_01}${bold}"
    user_at_host_end="${bold_none}${bg_none}${s_darkgray01_bgdarkgray}"
    user_symbol="${bg_dark_gray}${bold}${white}"
    user_symbol_end="${none}${bold_none}${bg_none}${s_darkgray_bgdarkgray01}"
    path="${bg_dark_gray_01}${white}${bold}"
    path_git="${bg_dark_gray_01}${white}  ${is_git_repo} ${bold}"
    path_end="${none}${bold_none}"
    branch="${s_darkgray01_bgwhite}${bg_white}${black}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_white}"

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${s_darkgray01_bglightyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_lightyellow}"
    fi

    if [ "$staged_files" = "" ]
    then
        has_added_files=""
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${s_darkgray01_bglightgreen}${bg_light_green}${black}${bold}"
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

    prompt_user="${user_at_host}\\u@\\h ${user_at_host_end}"
    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"
    prompt_path="${path}${bold}${white} \\w ${path_end}${s_darkgray01}"

    if [ "$branch_name" != "" ]
    then
        prompt_path="${path_git}${has_unpushed_commits}${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files} \\w ${path_end}"
        prompt_branch="${branch} ${branch_icon} ${branch_name} ${branch_end}"
        PS1="${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch} "
        return
    fi

    PS1="${prompt_user}${prompt_symbol}${prompt_path} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
