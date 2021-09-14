#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_prompt_builder() {
    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, please have a look at $HOME/.fancy-git/color_schemes.
    # Everything you need to do is creating a new file to the color scheme you wish to create.
    # After creating the new color scheme file, be sure to register its name to the $supported_color_schemes list, so
    # it'll be accepted by the theme.
    local supported_color_schemes
    local current_color_scheme

    # All color schemes for this theme must be registered here.
    supported_color_schemes=(
        "human"
    )

    # If the current color scheme is not one of $supported_color_schemes, it'll be ignored and will be set to the
    # default color scheme again.
    current_color_scheme=$(fancygit_get_color_scheme "${supported_color_schemes[*]}" "human")

    # Load the color scheme.
    . "$HOME/.fancy-git/color_schemes/$current_color_scheme"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local time_color_tag="\\[\\e[38;5;${fancygit_color_scheme_time_foreground}m\\]"
    local user_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_user_foreground}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_host_foreground}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_at_foreground}m\\]"
    local user_symbol_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_user_symbol_foreground}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_workdir_foreground}m\\]"
    local branch_color_staged_files_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_staged_files_foreground}m\\]"
    local branch_color_changed_files_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_changed_files_foreground}m\\]"
    local branch_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_branch_foreround}m\\]"
    local color_reset="\\[\\e[39m\\]"
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
    local branch_status=""
    local is_rich_notification

    # Get git repo info.
    branch_status=$(fancygit_git_get_status)
    staged_files=$(fancygit_git_get_staged_files)

    if [ "$branch_status" != "" ]
    then
        branch="${branch_color_changed_files_font_tag}"
        branch_end="${background_reset}${color_reset}"
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${branch_color_staged_files_font_tag}"
        branch_end="${background_reset}${color_reset}"
    fi

    # Check some config preferences.
    is_rich_notification=$(fancygit_config_get "show_rich_notification" "true")
    if fancygit_config_is "double_line" "true"
    then
        fancygit_PS2=$(fancygit_config_get "ps2" "➜")
        is_double_line="\n${fancygit_PS2}"
    fi

    if fancygit_config_is "show_time" "true"
    then
        time_format=$(fancygit_config_get "time_format" "%H:%M:%S")
        prompt_time="${time}[$(date +"$time_format")] ${time_end}"
    fi

    if fancygit_config_is "show_user_at_machine" "true"
    then
        prompt_user="${user}\\u${color_reset}${at} at ${color_reset}${host}\\h${color_reset}${user_at_host_end} in "
    fi

    path_sign="\\W"
    if fancygit_config_is "show_full_path" "true"
    then
        path_sign="\\w"
    fi

    prompt_symbol="${user_symbol}\$${user_symbol_end}"
    venv=$(__fancygit_get_venv_icon)
    prompt_path="${path}${venv}${path_sign}${path_end}${color_reset}"

    # If we have a branch name, it means we are in a git repo, so we need to make some changes on PS1.
    branch_name=$(fancygit_git_get_branch)
    if [ "${branch_name}" != "" ]
    then
        prompt_path="${path_git}${path_sign}${path_end}"
        prompt_branch="${branch}${branch_name}${branch_end}"
        PS1="${prompt_time}${prompt_user}${prompt_path} on ${prompt_branch}$(__fancygit_get_notification_area "$is_rich_notification")"
        PS1="${PS1}${prompt_symbol}${is_double_line} "
        return
    fi

    PS1="${prompt_time}${prompt_user}${prompt_path} ${prompt_symbol}${is_double_line} "
}

# Here's where the magic happens!
# It calls our main function (fancygit_prompt_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_prompt_builder"
