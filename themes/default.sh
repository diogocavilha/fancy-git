#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.08.2018

# ----------------------------------------------------------------------------------------------------------------------
# The main function to change the prompt.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_theme_builder() {
    check_for_update

    # !! IMPORTANT !!
    # If you're just interested on creating a new color scheme, please have a look at $HOME/.fancy-git/color_schemes.
    # Everything you need to do is creating a new file to the color scheme you wish to create.
    local color_scheme
    color_scheme=$(fancygit_config_get "color_scheme" "default_default")

    # Load the color scheme.
    . "${HOME}/.fancy-git/color_schemes/${color_scheme}"

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
    local prompt_user=""
    local venv
    local prompt_time
    local path_sign
    local double_line_config
    local is_rich_notification

    # Get some config preferences.
    is_rich_notification=$(fancygit_config_get "show_rich_notification" "true")

    # Get theme config.
    prompt_time="${time}$(fancygit_theme_get_time)${time_end}"
    path_sign=$(fancygit_theme_get_path_sign)
    double_line_config=$(fancygit_theme_get_double_line)

    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"

    if fancygit_config_is "show_user_at_machine" "true"
    then
        prompt_user="${user_at_host}${user}\\u${none}${at}@${none}${host}\\h${none} ${user_at_host_end}"
    fi

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

    # If we have a branch name, it means we are in a git repo, so we need to make some changes on PS1.
    branch_name=$(fancygit_git_get_branch)
    if [ "" != "$branch_name" ]
    then
        prompt_path="${path_git}$(fancygit_get_notification_area "$is_rich_notification")${path_sign} ${path_end}"
        prompt_branch="${branch} $(fancygit_git_get_branch_icon "${branch_name}") ${branch_name} ${branch_end}"
        PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch}${double_line_config} "
        return
    fi

    venv=$(__fancygit_get_venv_icon)
    prompt_path="${path}${venv} ${path_sign} ${path_end}${workdir_color_tag}${separator}${none}"
    PS1="${prompt_time}${prompt_user}${prompt_symbol}${prompt_path}${double_line_config} "
}

# Here's where the magic happens!
# It calls our main function (fancygit_theme_builder) in order to mount a beautiful PS1 prompt =D
PROMPT_COMMAND="fancygit_theme_builder"
