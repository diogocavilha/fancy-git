CONFIG_GIT_BRANCH_DELIMITERS[0]="("
CONFIG_GIT_BRANCH_DELIMITERS[1]=")"
CONFIG_GIT_BRANCH_ICON_CHANGED="✖"   # icons: ✖, x
CONFIG_GIT_BRANCH_ICON_UNCHANGED="✔" # icons: ✔

source ~/.fancy-git/aliases

fancygit_branch_status() {
    local icon=""
    local branch_status=$(git status -s 2> /dev/null)

    icon=$CONFIG_GIT_BRANCH_ICON_UNCHANGED

    if [ "$branch_status" != "" ]; then
        icon=$CONFIG_GIT_BRANCH_ICON_CHANGED
    fi

    echo $icon
}

fancygit_branch_name() {
    local branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

    if [ "$branch_name" != "" ]; then
        branch_name="${CONFIG_GIT_BRANCH_DELIMITERS[0]}$branch_name${CONFIG_GIT_BRANCH_DELIMITERS[1]} $(fancygit_branch_status) "
    fi

    echo "$branch_name"
}

PS1="$PS1\$(fancygit_branch_name)"
