#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    # Colors
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local none="\\[\\e[39m\\]"
    local red="\\[\\e[31m\\]"
    local orange="\\033[95;38;5;214m"

    local at="${red}at${none}"
    local in="${red}in${none}"
    local on="${red}on${none}"
    local venvfor="${red}for${none}"

    # Prompt
    local user="\u"
    local host="\h"
    local where="\W"
    local venv=""

    if fg_show_full_path
    then
        where="\w"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="`basename \"$VIRTUAL_ENV\"` ${venvfor} "
    fi

    if [ "$branch_name" != "" ]; then
        branch_name=" ${red}on${none} ${orange}$branch_name${none}"
    fi

    PS1="${bold}${venv}${user} ${at} ${host} ${in} $where$branch_name$(fg_branch_status 1) ${bold_none}\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"
