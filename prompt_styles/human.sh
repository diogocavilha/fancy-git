. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

fg_branch_status() {
    . ~/.fancy-git/config

    local branch_icon
    local branch_status
    local icon

    branch_icon="*" # ⚫, *
    unpushed_commits_icon="*" # ▲, *

    branch_status=$(git status -s 2> /dev/null)
    icon=${light_green}$branch_icon${none}

    if [ "$branch_status" != "" ]; then
        icon=${light_yellow}$branch_icon${none}
    fi

    if [ "$git_has_unpushed_commits" != "" ]
    then
        icon=${light_yellow}${unpushed_commits_icon}${none}
    fi

    echo "$icon "
}

fg_branch_name() {
    local branch_name

    branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

    if [ "$branch_name" != "" ]; then
        branch_name="($branch_name) $(fg_branch_status)"
    fi

    echo " $branch_name"
}

fancygit_prompt_builder() {
    . ~/.fancy-git/config

    local user
    local at
    local host
    local where

    user="${light_green}\u${none}"
    at="${none} at ${none}"
    host="${light_green}\h${none}"
    where="${blue}\w${none}"

    PS1="${bold}$user$at$host in $where\$$(fg_branch_name)${bold_none}"
}

PROMPT_COMMAND="fancygit_prompt_builder"

