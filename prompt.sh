#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018
#
# Changes de prompt by loading the style configured in ~/.fancygit/mode file.

function fancygit_prompt_changer() {
    local style

    style=$(cat ~/.fancy-git/mode)

    if [ -e ~/.fancy-git/prompt_styles/"$style.sh" ]; then
        . ~/.fancy-git/prompt_styles/"$style.sh"
        return
    fi

    . ~/.fancy-git/prompt_styles/default.sh
}

fancygit_prompt_changer
