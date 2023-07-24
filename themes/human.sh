#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_builder() {
    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, please have a look at $HOME/.fancy-git/color_schemes.
    # Everything you need to do is creating a new file to the color scheme you wish to create.
    local color_scheme
    color_scheme=$(fancygit_config_get "color_scheme" "human_human")

    # Load the color scheme.
    # shellcheck source=/dev/null
    . "${HOME}/.fancy-git/color_schemes/${color_scheme}"

    # !! WARNING !!
    # From here you better now what you're doing. Have fun =D

    # Create color tags to change prompt style.
    local time_color_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_TIME_FOREGROUND}m\\]"
    local user_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_USER_FOREGROUND}m\\]"
    local host_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_HOST_FOREGROUND}m\\]"
    local at_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_AT_FOREGROUND}m\\]"
    local preposition_color="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_PREPOSITION_FOREGROUND}m\\]"
    local user_symbol_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_USER_SYMBOL_FOREGROUND}m\\]"
    local workdir_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_WORKDIR_FOREGROUND}m\\]"
    local branch_color_staged_files_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_BRANCH_STAGED_FILES_FOREGROUND}m\\]"
    local branch_color_changed_files_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_BRANCH_CHANGED_FILES_FOREGROUND}m\\]"
    local branch_color_font_tag="\\[\\e[38;5;${FANCYGIT_COLOR_SCHEME_BRANCH_FOREROUND}m\\]"
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
    local prompt_user_at_host=""
    local branch_status
    local staged_files
    local is_rich_notification
    local prompt_time
    local path_sign
    local is_double_line
    local venv_name
    local prompt_symbol
    local prompt_path
    local term_title
    local bold_prompt=""
    local normal_prompt=""

    local user_name
    user_name=$(fancygit_config_get "user_name" "\\u")

    local host_name
    host_name=$(fancygit_config_get "host_name" "\\h")

    # Get git repo info.
    branch_status=$(fancygit_git_get_status)
    staged_files=$(fancygit_git_get_staged_files)

    # Get some config preferences.
    is_rich_notification=$(fancygit_config_get "show_rich_notification" "true")

    # Get theme config.
    prompt_time="${time}$(fancygit_theme_get_time)${time_end}"
    path_sign=$(fancygit_theme_get_path_sign)
    is_double_line=$(fancygit_theme_get_double_line)
    venv_name=$(fancygit_theme_get_venv_name)

    prompt_symbol="${user_symbol}\$${user_symbol_end}"
    prompt_path="${path}${path_sign}${path_end}${color_reset}"

    if fancygit_config_is "show_user_symbol_prompt" "false"
    then
        prompt_symbol=""
    fi

    local term_title_tag="\\[\\e]0;"
    if fancygit_config_is "set_term_title_host" "true"
    then
        term_title_tag="${term_title_tag}\\h:"
    fi
    if fancygit_config_is "set_term_title_path" "true"
    then
        term_title_tag="${term_title_tag}\\w"
    fi
    term_title="${term_title_tag}\\a\\]"

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

    if [ "" != "$venv_name" ]
    then
        venv_name=" env ${user}${venv_name}${color_reset}"
    fi

    if fancygit_config_is "show_user_at_machine" "true"
    then
        prompt_user_at_host="${user}${user_name}${color_reset}${at} at ${color_reset}${host}${host_name}${color_reset}${user_at_host_end} in "
    fi

    if fancygit_config_is "show_host_prompt" "false"
    then
        prompt_user_at_host="${user}${user_name}${color_reset}${preposition_color} in "
    fi

    if fancygit_config_is "bold_prompt" "true"
    then
        bold_prompt="\\[\\e[1m\\]"
        normal_prompt="\\[\\e[0m\\]"
    fi

    # If we have a branch name, it means we are in a git repo, so we need to make some changes on PS1.
    branch_name=$(fancygit_git_get_branch)

    if [ "HEAD" = "$branch_name" ]
    then
        branch_name="$(fancygit_git_get_tag)"
    fi

    if [ "${branch_name}" != "" ]
    then
        prompt_path="${path_git}${path_sign}${path_end}"
        prompt_branch="${branch}${branch_name}${branch_end}"
        PS1="${prompt_time}${prompt_user_at_host}${prompt_path}${venv_name}${preposition_color} on ${prompt_branch}$(fancygit_get_notification_area "$is_rich_notification")"
        PS1="${term_title}${bold_prompt}${PS1}${prompt_symbol}${is_double_line}${normal_prompt} "
        return
    fi

    PS1="${term_title}${bold_prompt}${prompt_time}${prompt_user_at_host}${prompt_path}${venv_name}${prompt_symbol}${is_double_line}${normal_prompt} "
}

# Here's where the magic happens!
# It calls our main function (fancygit_theme_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_theme_builder"
