#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

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
        info="${info}${light_green}>${none} "
    fi

    if [ "$info" != "" ]; then
        info=$(echo "$info" | sed -e 's/[[:space:]]*$//')
        echo "[$info]"
        return
    fi

    echo ""
}

fg_branch_name() {
    local light_magenta="\\[\\e[95m\\]"
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    local only_local_branch=$(git branch -a 2> /dev/null | egrep "remotes/origin/${branch_name}" | wc -l)
    local light_green="\\[\\e[92m\\]"
    local none="\\[\\e[39m\\]"

    if [ "$branch_name" != "" ] && [ "$only_local_branch" -eq 0 ]; then
        branch_name="${light_magenta}$branch_name${none}${light_green}*${none}"
    fi

    if [ "$branch_name" != "" ]; then
        branch_name="on ${light_magenta}$branch_name${none}"
    fi

    echo "$branch_name $(fg_branch_status)"
}

fancygit_prompt_builder() {
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    # Colors
    local blue="\\[\\e[34m\\]"
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local light_green="\\[\\e[92m\\]"
    local light_yellow="\\[\\e[93m\\]"
    local none="\\[\\e[39m\\]"
    local orange="\\033[95;38;5;214m"

    # Prompt
    local user="${orange}\u${none}"
    local host="${light_yellow}\h${none}"
    local where="${light_green}\w${none}"
    local venv=""

    if ! fg_show_full_path
    then
        where="${light_green}\W${none}"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="${light_yellow}`basename \"$VIRTUAL_ENV\"`${none} for "
    fi

    PS1="${bold}${venv}${user} at ${host} in $where $(fg_branch_name)${bold_none}\n\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"

