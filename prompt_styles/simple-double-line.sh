#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.12.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fg_branch_status() {
    . ~/.fancy-git/config.sh

    local info=""

    if [ "$git_has_unpushed_commits" ]
    then
        info="${info}${light_green}${git_number_unpushed_commits}^${none} "
    fi

    if [ "$git_number_untracked_files" -gt 0 ]
    then
        info="${info}${cyan}?${none} "
    fi

    if [ "$git_number_changed_files" -gt 0 ]
    then
        info="${info}${light_green}+${none}${light_red}-${none} "
    fi

    if [ "$git_stash" != "" ]
    then
        info="${info}∿${none} "
    fi

    if [ "$staged_files" != "" ]
    then
        info="${info}${light_green}✔${none} "
    fi

    if [ "$info" != "" ]; then
        info=$(echo "$info" | sed -e 's/[[:space:]]*$//')
        echo "$info"
        return
    fi

    echo ""
}

fg_branch_name() {
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    local only_local_branch=$(git branch -a 2> /dev/null | egrep "remotes/origin/${branch_name}" | wc -l)
    local branch_status=$(fg_branch_status)
    local light_green="\\[\\e[92m\\]"
    local none="\\[\\e[39m\\]"

    if [ "$branch_name" != "" ] && [ "$only_local_branch" -eq 0 ]; then
        branch_name="$branch_name${light_green}*${none}"
    fi

    if [ "$branch_status" != "" ]; then
        branch_name="$branch_name | $branch_status"
    fi

    if [ "$branch_name" != "" ]; then
        echo " ($branch_name)"
        return
    fi

    echo ""
}

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    local user
    local at
    local host
    local where
    local venv=""

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

    PS1="${bold}${venv}$user$at$host:$where$(fg_branch_name)${bold_none}\n\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"
