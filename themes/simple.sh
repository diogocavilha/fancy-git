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
    # After creating your new color scheme file, be sure to add its name to the $supported_color_schemes array, so it'll
    # be accepted by the theme.
    local supported_color_schemes
    local current_color_scheme

    # New color scheme names must be added here.
    supported_color_schemes=(
        "simple"
    )

    # Any color scheme other than $supported_color_schemes will be ignored.
    # It will be set to the default color scheme again.
    current_color_scheme=$(fancygit_config_get "color_scheme" "default")
    if [[ ! " ${supported_color_schemes[*]} " =~ ${current_color_scheme} ]]
    then
        fancygit_config_save "color_scheme" "simple"
        current_color_scheme="simple"
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
    local venv_name=""
    local prompt_time=""
    local branch_area=""
    local is_double_line=""
    local where=""

    # Check some config preferences.
    if fancygit_config_is "double-line" "true"
    then
        fancygit_PS2=$(fancygit_config_get "ps2" "➜")
        is_double_line="\n${fancygit_PS2}"
    fi

    if fancygit_config_is "show-time" "true"
    then
        time_format=$(fancygit_config_get "time-format" "%H:%M:%S")
        prompt_time="[$(date +"$time_format")] "
    fi

    if fancygit_config_is "show-user-at-machine" "true"
    then
        user_at_host="$user$at$host:"
    fi

    path_sign="\\W"
    if fancygit_config_is "show-full-path" "true"
    then
        path_sign="\\w"
    fi

    venv_name=$(fancygit_get_venv_name)
    branch_area=$(__fancygit_theme_get_branch_area)
    where="${path}${path_sign}${color_reset}"
    PS1="${venv_name}${prompt_time}${user_at_host}$where\$${branch_area}${is_double_line} "
}

# ----------------------------------------------------------------------------------------------------------------------
# Create the branch area, containing the branch name and status icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_theme_get_branch_area() {
    local branch_name
    local branch_status

    branch_name=$(fancygit_git_get_branch)
    branch_status=$(__fancygit_get_notification_area "false")
    branch_status=$(echo "$branch_status" | sed -e 's/[[:space:]]*$//')

    if [ "$branch_status" != "" ]
    then
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
