#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fg_branch_status() {
    . ~/.fancy-git/config.sh

    local info
    info=""

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
        info="${info}~${none} "
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

    if [ "$branch_name" != "" ]; then
        branch_name="on ${light_magenta}$branch_name${none} $(fg_branch_status)"
    fi

    echo "$branch_name"
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

    PS1="${bold}${user} at ${host} in $where $(fg_branch_name)${bold_none}\n\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"

