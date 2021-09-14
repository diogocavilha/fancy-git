#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.06.2018

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
        "simple"
    )

    # If the current color scheme is not one of $supported_color_schemes, it'll be ignored and will be set to the
    # default color scheme again.
    current_color_scheme=$(fancygit_get_color_scheme "${supported_color_schemes[*]}" "simple")

    if [ $? -eq 1 ]
    then
        echo ""
        echo " > Color scheme not supported by this theme."
        echo " > Getting back to --color-scheme-simple."
        echo ""
    fi

    # Load the color scheme.
    . "$HOME/.fancy-git/color_schemes/$current_color_scheme"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local user_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_user_foreground}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_host_foreground}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_at_foreground}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${fancygit_color_scheme_workdir_foreground}m\\]"
    local color_reset="\\[\\e[39m\\]"

    # Prompt style.
    local user="${user_color_font_tag}\u${color_reset}"
    local host="${host_color_font_tag}\h${color_reset}"
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

    PS1="${venv_name}${prompt_time}${user_at_host}$where\$${branch_area}${is_double_line} "
}

# ----------------------------------------------------------------------------------------------------------------------
# Create the branch area, containing the branch name and status icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_theme_get_branch_area() {
    local is_rich_notification
    local branch_name
    local branch_status

    is_rich_notification=$(fancygit_config_get "show_rich_notification" "false")

    branch_name=$(fancygit_git_get_branch)
    branch_status=$(fancygit_get_notification_area "$is_rich_notification")
    branch_status=$(echo "$branch_status" | sed -e 's/[[:space:]]*$//')

    if [ "$branch_status" != "" ]
    then
        if [ "true" = "$is_rich_notification" ]
        then
            branch_status=" [ $(echo "$branch_status" | sed -e 's/^[[:space:]]*//') ]"
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
# It calls our main function (fancygit_prompt_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_prompt_builder"
