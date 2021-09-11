#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.08.2018

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_prompt_builder() {
    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, check $HOME/.fancy-git/color_schemes.
    # It'll be handled in order to create the proper color on PS1 prompt.
    local color_scheme_name

    color_scheme_name=$(fancygit_config_get "style" "default")
    . "$HOME/.fancy-git/color_schemes/$color_scheme_name"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local time_color_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_time_background}m\\]"
    local time_color_tag="\\[\\e[38;5;${fancygit_color_scheme_time_foreground}m\\]"
    local user_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_user_foreground}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_host_foreground}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_at_foreground}m\\]"
    local user_symbol_color_tag="\\[\\e[38;5;${fancygit_color_scheme_user_symbol_background}m\\]"
    local user_symbol_color_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_user_symbol_background}m\\]"
    local user_symbol_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_user_symbol_foreground}m\\]"
    local workdir_color_tag="\\[\\e[38;5;${fancygit_color_scheme_workdir_background}m\\]"
    local workdir_color_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_workdir_background}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_workdir_foreground}m\\]"
    local user_at_host_color_tag="\\[\\e[38;5;${fancygit_color_scheme_user_at_host_background}m\\]"
    local user_at_host_color_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_user_at_host_background}m\\]"
    local branch_color_staged_files_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_staged_files_background}m\\]"
    local branch_color_staged_files_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_branch_staged_files_background}m\\]"
    local branch_color_staged_files_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_staged_files_foreground}m\\]"
    local branch_color_changed_files_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_changed_files_background}m\\]"
    local branch_color_changed_files_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_branch_changed_files_background}m\\]"
    local branch_color_changed_files_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_changed_files_foreground}m\\]"
    local branch_color_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_background}m\\]"
    local branch_color_bg_tag="\\[\\e[48;5;${fancygit_color_scheme_branch_background}m\\]"
    local branch_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_foreround}m\\]"
    local none="\\[\\e[39m\\]"
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local bg_none="\\[\\e[49m\\]"

    # Prompt style
    local separator
    separator=$(fancygit_config_get "separator" "")

    local icon_git_repo=""
    local user="${bold}${user_color_font_tag}"
    local host="${bold}${host_color_font_tag}"
    local at="${bold}${at_color_font_tag}"
    local user_at_host="${bold}${user_at_host_color_bg_tag}"
    local user_at_host_end="${bold_none}${bg_none}${user_at_host_color_tag}${user_symbol_color_bg_tag}${separator}"
    local user_symbol="${user_symbol_color_bg_tag}${bold}${user_symbol_color_font_tag}"
    local user_symbol_end="${none}${bold_none}${bg_none}${user_symbol_color_tag}${workdir_color_bg_tag}${separator}"
    local path="${workdir_color_bg_tag}${workdir_color_font_tag}${bold}"
    local path_git="${workdir_color_bg_tag}${workdir_color_font_tag} ${icon_git_repo} ${bold}"
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
    local is_rich_notification

    # Read some config settings.
    is_rich_notification=$(fancygit_config_get "show-rich-notification" "true")
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
    if [ "" != "$(fancygit_git_get_status)" ]
    then
        branch="${workdir_color_tag}${branch_color_changed_files_bg_tag}${separator}${branch_color_changed_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_changed_files_tag}${separator}${none}"
    fi

    # Configure a specific background color to branch name, if it has staged files.
    if [ "" != "$(fancygit_git_get_staged_files)" ]
    then
        branch="${workdir_color_tag}${branch_color_staged_files_bg_tag}${separator}${branch_color_staged_files_font_tag}${bold}"
        branch_end="${bg_none}${bold_none}${branch_color_staged_files_tag}${separator}${none}"
    fi

    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"

    # If we have a branch name, it means we are in a git repo, so we need to make some changes on PS1.
    branch_name=$(fancygit_git_get_branch)
    if [ "" != "$branch_name" ]
    then
        prompt_path="${path_git}$(__fancygit_get_notification_area "$is_rich_notification")${path_sign} ${path_end}"
        prompt_branch="${branch} $(fancygit_git_get_branch_icon "${branch_name}") ${branch_name} ${branch_end}"
        PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch}${double_line_config} "
        return
    fi

    venv=$(__fancygit_get_venv_icon)
    prompt_path="${path}${bold}${venv} $path_sign ${path_end}${workdir_color_tag}${separator}${none}"
    PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${double_line_config} "
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

# Here's where the magic happens!
# It calls our main function (fancygit_prompt_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_prompt_builder"
