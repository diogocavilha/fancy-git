. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/config
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    # Prompt style
    user_at_host="${white}${bg_dark_gray}${bold}"
    user_at_host_end="${bold_none}${bg_none}${s_darkgray_bgblue}"
    path="${bg_blue}${white}${bold}"
    path_git="${bg_blue}${white}  ${is_git_repo} ${bold}"
    path_end="${none}${bold_none}"
    user_symbol="${bg_dark_gray}${bold}${white}"
    user_symbol_end="${none}${bold_none}${bg_none}${s_dark_gray_bgnone}"
    branch="${s_blue_bgwhite}${bg_white}${black}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_white}"

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${s_blue_bglightyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_lightyellow}"
    fi

    if [ "$staged_files" = "" ]
    then
        has_added_files=""
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${s_blue_bglightgreen}${bg_light_green}${black}${bold}"
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
    prompt_symbol="\n${user_symbol}\$${user_symbol_end}"
    prompt_path="${path}${bold}${white} \\w ${path_end}${s_blue}"

    if [ "$branch_name" != "" ]
    then
        prompt_path="${path_git}${has_unpushed_commits}${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files} \\w ${path_end}"
        prompt_branch="${branch} ${branch_icon} ${branch_name} ${branch_end}"
        PS1="${prompt_user}${prompt_path}${prompt_branch}${prompt_symbol} "
        return
    fi

    PS1="${prompt_user}${prompt_path}${prompt_symbol} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
