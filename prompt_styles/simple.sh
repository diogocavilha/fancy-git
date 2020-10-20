#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.06.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fg_branch_name() {
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    local branch_status=$(fg_branch_status)

    if [ "$branch_status" != "" ]; then
        branch_name="$branch_name |$branch_status"
    fi

    if [ "$branch_name" != "" ]; then
        echo " ($branch_name)"
        return
    fi

    echo ""
}

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh
    
    check_for_update

    local user
    local at
    local host
    local where
    local venv=""
    local user_at_host=""

    user="${light_green}\u${none}"
    at="${none}@${none}"
    host="${light_green}\h${none}"
    where="${blue}\w${none}"

    if ! fg_show_full_path
    then
        where="${blue}\W${none}"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="(`basename \"$VIRTUAL_ENV\"`) "
    fi

    if ([ ${CONDA_DEFAULT_ENV} != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ]); then
        venv="(`basename \"$CONDA_DEFAULT_ENV\"`) "
    fi

    if fg_show_user_at_machine
    then
        user_at_host="$user$at$host:"
    fi

    PS1="${bold}${venv}${user_at_host}$where\$$(fg_branch_name)${bold_none} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
