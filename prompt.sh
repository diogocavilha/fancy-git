#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     06.11.2018
#
# Changes de prompt by loading the style configured in ~/.fancygit/mode file.

function fancygit_prompt_changer() {
    local mode
    local fallback_style
    local styles_dir
    local style_path
    local prompt_command
    local prompt_command_fallback
    local base_path

    base_path="/home/$USER/.fancy-git"

    if [ ! -d "$base_path" ]; then
        styles_dir="/Users/$USER/.fancy-git"
    fi

    mode=$(cat ~/.fancy-git/mode)
    fallback_style="default.sh"
    styles_dir="$base_path/prompt_styles"
    style_path="$styles_dir/$mode.sh"
    prompt_command=". $style_path"
    prompt_command_fallback=". $styles_dir/$fallback_style"

    if [ -e "$style_path" ]; then
        eval "$prompt_command"
        return
    fi

    eval "$prompt_command_fallback"
}

fancygit_prompt_changer
