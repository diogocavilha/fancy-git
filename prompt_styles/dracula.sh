#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   12.01.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update

    # Skin color config.
    # This is the only config that must be changed by user.
    local time_background="59"
    local time_foreground="231"
    local user_symbol_background="207"
    local user_symbol_foreground="231"
    local workdir_background="61"
    local workdir_foreground="231"
    local user_at_host_background="59"
    local user_foreground="231"
    local host_foreground="231"
    local at_foreground="231"
    local branch_background="231"
    local branch_foreround="0"
    local branch_staged_files_background="120"
    local branch_staged_files_foreground="0"
    local branch_changed_files_background="222"
    local branch_changed_files_foreground="0"

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
    local user="${bold}${user_color_font_tag}"
    local host="${bold}${host_color_font_tag}"
    local at="${bold}${at_color_font_tag}"
    local user_at_host="${bold}${user_at_host_color_bg_tag}"
    local user_at_host_end="${bold_none}${bg_none}${user_at_host_color_tag}${user_symbol_color_bg_tag}${separator}"
    local user_symbol="${user_symbol_color_bg_tag}${bold}${user_symbol_color_font_tag}"
    local user_symbol_end="${none}${bold_none}${bg_none}${user_symbol_color_tag}${workdir_color_bg_tag}${separator}"
    local path="${workdir_color_bg_tag}${workdir_color_font_tag}${bold}"
    local path_git="${workdir_color_bg_tag}${workdir_color_font_tag}  ${is_git_repo} ${bold}"
    local path_end="${none}${bold_none}"
    local branch="${workdir_color_tag}${branch_color_bg_tag}${separator}${branch_color_font_tag}${bold}"
    local branch_end="${branch_color_tag}${bg_none}${separator}${bold_none}${none}"
    local time="${time_color_bg_tag}${time_color_tag}${bold}"
    local time_end="${bold_none}${bg_none}"

    local venv=""
    local path_sign=""
    local prompt_user=""
    local prompt_time=""
    local fancygit_PS2=""
    local double_line_config=""

    fancygit_PS2=$(fancygit_config_get "ps2")

    if fancygit_config_is "double-line" "true"
    then
        double_line_config="\n${fancygit_PS2}"
    fi

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${workdir_color_tag}${branch_color_changed_files_bg_tag}${separator}${branch_color_changed_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_changed_files_tag}${separator}${none}"
    fi

    if [ "$staged_files" = "" ]
    then
        has_added_files=""
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${workdir_color_tag}${branch_color_staged_files_bg_tag}${separator}${branch_color_staged_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_staged_files_tag}${separator}${none}"
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

    if fancygit_config_is "show-time" "true"
    then
      formatted_time=$(date +"${time_format}")
      prompt_time="${time}[${formatted_time}] ${time_end}"
    fi

    if fancygit_config_is "show-user-at-machine" "true"
    then
        prompt_user="${user_at_host}${user}\\u${none}${at}@${none}${host}\\h${none} ${user_at_host_end}"
    fi

    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"

    if ! [ -z ${VIRTUAL_ENV} ] || ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        venv="$working_on_venv"
    fi

    path_sign="\\W"
    if fancygit_config_is "show-full-path" "true"
    then
        path_sign="\\w"
    fi

    prompt_path="${path}${bold}${venv} $path_sign ${path_end}${workdir_color_tag}${separator}${none}"

    if [ "$branch_name" != "" ]
    then
        branch_icon=$(fg_get_branch_icon)
        prompt_path="${path_git}${venv}${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files}${has_unpushed_commits} $path_sign ${path_end}"
        prompt_branch="${branch} ${branch_icon} ${branch_name} ${branch_end}"
        PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch}${double_line_config} "
        return
    fi

    PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${double_line_config} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
