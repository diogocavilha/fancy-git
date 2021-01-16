#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update

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
    local user_at_host=""

    if fg_show_full_path
    then
        where="\w"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="`basename \"$VIRTUAL_ENV\"` ${venvfor} "
    fi

    if ([ ${CONDA_DEFAULT_ENV} != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ]); then
        venv="`basename \"$CONDA_DEFAULT_ENV\"` ${venvfor} "
    fi

    if [ "$branch_name" != "" ]; then
        branch_name="${on} ${orange}$branch_name${none}"
    fi

    if fg_show_user_at_machine
    then
        user_at_host="${user} ${at} ${host} ${in} "
    fi

    PS1="${bold}${venv}${user_at_host}$where $branch_name$(fg_branch_status 1)${bold_none}\n\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"
