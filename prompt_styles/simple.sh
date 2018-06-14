. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

fg_branch_status() {
    . ~/.fancy-git/config

    local branch_icon
    local info
    local icon

    branch_icon="⚫"
    icon=${light_green}${branch_icon}${none}
    info=""

    if [ "$branch_status" != "" ]; then
        icon=${light_yellow}${branch_icon}${none}
    fi

    if [ "$git_has_unpushed_commits" != "" ]
    then
        info="${info}+${git_number_unpushed_commits}c "
        icon="${light_yellow}▲${none}"
    fi

    if [ "$git_number_untracked_files" -gt 0 ]
    then
        info="${info}+${git_number_untracked_files}f "
        icon="${light_yellow}${branch_icon}${none}"
    fi

    if [ "$git_number_changed_files" -gt 0 ]
    then
        info="${info}${git_number_changed_files}m "
        icon="${light_yellow}${branch_icon}${none}"
    fi

    echo "$info$icon "
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
    at="${none}@${none}"
    host="${light_green}\h${none}"
    where="${blue}\w${none}"

    PS1="${bold}$user$at$host:$where\$$(fg_branch_name)${bold_none}"
}

PROMPT_COMMAND="fancygit_prompt_builder"

