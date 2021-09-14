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
    # If you're just interested on creating a new color scheme, please have a look at $HOME/.fancy-git/color_schemes.
    # Everything you need to do is creating a new file to the color scheme you wish to create.
    # After creating the new color scheme file, be sure to register its name to the $supported_color_schemes list, so
    # it'll be accepted by the theme.
    local supported_color_schemes
    local current_color_scheme

    # All color schemes for this theme must be registered here.
    supported_color_schemes=(
        "default"
        "dracula"
        "dark"
        "dark-col"
        "light"
    )

    # If the current color scheme is not one of $supported_color_schemes, it'll be ignored and will be set to the
    # default color scheme again.
    current_color_scheme=$(fancygit_get_color_scheme "${supported_color_schemes[*]}" "default")

    # Load the color scheme.
    . "$HOME/.fancy-git/color_schemes/$current_color_scheme"

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
    local bold_none="\\[\\e[0m\\]"
    local bg_none="\\[\\e[49m\\]"

    # Prompt style
    local separator
    separator=$(fancygit_config_get "separator" "")

    local icon_git_repo=""
    local user="${user_color_font_tag}"
    local host="${host_color_font_tag}"
    local at="${at_color_font_tag}"
    local user_at_host="${user_at_host_color_bg_tag}"
    local user_at_host_end="${bold_none}${bg_none}${user_at_host_color_tag}${user_symbol_color_bg_tag}${separator}"
    local user_symbol="${user_symbol_color_bg_tag}${user_symbol_color_font_tag}"
    local user_symbol_end="${none}${bold_none}${bg_none}${user_symbol_color_tag}${workdir_color_bg_tag}${separator}"
    local path="${workdir_color_bg_tag}${workdir_color_font_tag}"
    local path_git="${workdir_color_bg_tag}${workdir_color_font_tag} ${icon_git_repo} "
    local path_end="${none}${bold_none}"
    local branch="${workdir_color_tag}${branch_color_bg_tag}${separator}${branch_color_font_tag}"
    local branch_end="${branch_color_tag}${bg_none}${separator}${bold_none}${none}"
    local time="${time_color_bg_tag}${time_color_tag}"
    local time_end="${bold_none}${bg_none}"
    local venv=""
    local path_sign=""
    local prompt_user=""
    local double_line_config=""
    local time_format=""
    local prompt_time=""
    local is_rich_notification

    # Read some config settings.
    is_rich_notification=$(fancygit_config_get "show_rich_notification" "true")
    if fancygit_config_is "double_line" "true"
    then
        double_line_config="\n$(fancygit_config_get "ps2" "➜")"
    fi

    if fancygit_config_is "show_time" "true"
    then
        time_format=$(fancygit_config_get "time_format" "%H:%M:%S")
        prompt_time="${time}[$(date +"${time_format}")] ${time_end}"
    fi

    if fancygit_config_is "show_user_at_machine" "true"
    then
        prompt_user="${user_at_host}${user}\\u${none}${at}@${none}${host}\\h${none} ${user_at_host_end}"
    fi

    path_sign="\\W"
    if fancygit_config_is "show_full_path" "true"
    then
        path_sign="\\w"
    fi

    # Building prompt

    # Configure a specific background color to branch name, if it has some change.
    if [ "" != "$(fancygit_git_get_status)" ]
    then
        branch="${workdir_color_tag}${branch_color_changed_files_bg_tag}${separator}${branch_color_changed_files_font_tag}"
        branch_end="${bg_none}${bold_none}${branch_color_changed_files_tag}${separator}${none}"
    fi

    # Configure a specific background color to branch name, if it has staged files.
    if [ "" != "$(fancygit_git_get_staged_files)" ]
    then
        branch="${workdir_color_tag}${branch_color_staged_files_bg_tag}${separator}${branch_color_staged_files_font_tag}"
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
    prompt_path="${path}${venv} $path_sign ${path_end}${workdir_color_tag}${separator}${none}"
    PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${double_line_config} "
}

# Here's where the magic happens!
# It calls our main function (fancygit_prompt_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_prompt_builder"
