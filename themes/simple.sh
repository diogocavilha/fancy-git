#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.06.2018

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_builder() {
    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, please have a look at $HOME/.fancy-git/color_schemes.
    # Everything you need to do is creating a new file to the color scheme you wish to create.
    local color_scheme
    color_scheme=$(fancygit_config_get "color_scheme" "simple_simple")

    # Load the color scheme.
    . "${HOME}/.fancy-git/color_schemes/${color_scheme}"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local user_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_USER_FOREGROUND}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_HOST_FOREGROUND}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_AT_FOREGROUND}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_WORKDIR_FOREGROUND}m\\]"
    local color_reset="\\[\\e[39m\\]"

    local user_name
    user_name=$(fancygit_config_get "user_name" "\\u")

    local host_name
    host_name=$(fancygit_config_get "host_name" "\\h")

    # Prompt style.
    local user="${user_color_font_tag}${user_name}${color_reset}"
    local host="${host_color_font_tag}${host_name}${color_reset}"
    local at="${at_color_font_tag}@${color_reset}"
    local path="${workdir_color_font_tag}"
    local prompt_time
    local path_sign
    local is_double_line
    local venv_name
    local branch_area
    local where

    # Get theme config.
    prompt_time="$(fancygit_theme_get_time)"
    path_sign=$(fancygit_theme_get_path_sign)
    is_double_line=$(fancygit_theme_get_double_line)
    venv_name=$(fancygit_theme_get_venv_name)
    branch_area=$(__fancygit_theme_get_branch_area)
    where="${path}${path_sign}${color_reset}"

    if fancygit_config_is "show_user_at_machine" "true"
    then
        user_at_host="$user$at$host:"
    fi

    if [ "" != "$venv_name" ]
    then
        venv_name="($venv_name) "
    fi

    PS1="${venv_name}${prompt_time}${user_at_host}$where\$${branch_area}${is_double_line} "
}

# ----------------------------------------------------------------------------------------------------------------------
# Create the branch area, containing the branch name and status icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_theme_get_branch_area() {
    local is_rich_notification
    local branch_name
    local branch_status
    local show_tag_name

    is_rich_notification=$(fancygit_config_get "show_rich_notification" "false")
    show_tag_name=$(fancygit_config_get "show_tag_name" "true")

    branch_name=$(fancygit_git_get_branch)
    branch_status=$(fancygit_get_notification_area "$is_rich_notification")
    branch_status=$(echo "$branch_status" | sed -e 's/[[:space:]]*$//')

    if [ "$branch_status" != "" ]
    then
        if [ "true" = "$is_rich_notification" ]
        then
            branch_status=" [ $(echo "$branch_status" | sed -e 's/^[[:space:]]*//') ]"
        fi

        if [ "HEAD" = "$branch_name" ] && [ "true" = "$show_tag_name" ]
        then
            branch_name=$(fancygit_git_get_tag)
        fi

        branch_name="${branch_name}${branch_status}"
    fi

    if [ "$branch_name" != "" ]
    then
        echo " ($branch_name)"
        return
    fi

    echo ""
}

# Here's where the magic happens!
# It calls our main function (fancygit_theme_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_theme_builder"
