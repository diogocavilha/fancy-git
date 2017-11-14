. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

NONE="\[\e[39m\]"
BOLD="\[\e[1m\]"
BOLD_NONE="\[\e[0m\]"
BG_NONE="\[\e[49m\]"
BG_DARK_GRAY="\[\e[100m\]"
BG_YELLOW="\[\e[43m\]"
BG_WHITE="\[\e[107m\]"
BG_BLUE="\[\e[44m\]"
DARK_GRAY="\[\e[90m\]"
BLUE="\[\e[34m\]"
BLACK="\[\e[30m\]"
WHITE="\[\e[97m\]"
YELLOW="\[\e[33m\]"

CONNECTOR=""

C_DARKGRAY_BGBLUE="${DARK_GRAY}${BG_BLUE}${CONNECTOR}${BG_NONE}${NONE}"
C_BLUE_BGDARKGRAY="${BLUE}${BG_DARK_GRAY}${CONNECTOR}${BG_NONE}${NONE}${BG_NONE}"
C_BLUE_BGYELLOW="${BLUE}${BG_YELLOW}${CONNECTOR}${BG_NONE}${NONE}${BG_NONE}"
C_DARKGRAY_BGYELLOW="${DARK_GRAY}${BG_YELLOW}${CONNECTOR}${BG_NONE}${NONE}"
C_DARKGRAY_BGWHITE="${DARK_GRAY}${BG_WHITE}${CONNECTOR}${BG_NONE}${NONE}"
C_DARKGRAY="${DARK_GRAY}${CONNECTOR}${NONE}"
C_BLUE="${BLUE}${CONNECTOR}${NONE}"
C_YELLOW="${YELLOW}${CONNECTOR}${NONE}"
C_WHITE="${WHITE}${CONNECTOR}${NONE}"

fg_get_branch_name() {
    local branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    echo "$branch_name"
}

fg_branch_status() {
    BRANCH="${C_DARKGRAY_BGWHITE}${BG_WHITE}${BLACK}${BOLD}"
    BRANCH_END="${BG_NONE}${NONE}${BOLD_NONE}${C_WHITE}"

    local branch_status=$(git status -s 2> /dev/null)

    if [ "$branch_status" != "" ]; then
        BRANCH="${C_DARKGRAY_BGYELLOW}${BG_YELLOW}${BOLD}"
        BRANCH_END="${BG_NONE}${BOLD_NONE}${C_YELLOW}"
    fi

    local branch_name=$(fg_get_branch_name)
    local branch="${BRANCH} ${branch_name} ${BRANCH_END}"

    if [ "$branch_name" != "" ]; then
        PS1="${WHITE}${BG_DARK_GRAY}${BOLD}\u@\h ${BOLD_NONE}${BG_NONE}${C_DARKGRAY_BGBLUE}"
        PS1=$PS1"${BG_BLUE}${BOLD}${WHITE} \w ${NONE}${BOLD_NONE}$C_BLUE_BGDARKGRAY"
        PS1=$PS1"${BG_DARK_GRAY}${BOLD}${WHITE} \$ ${NONE}${BOLD_NONE}${BG_NONE}${NONE}"
        PS1=$PS1"$branch "
        return
    fi

    PS1="${WHITE}${BG_DARK_GRAY}${BOLD}\u@\h ${BOLD_NONE}${BG_NONE}${C_DARKGRAY_BGBLUE}"
    PS1=$PS1"${BG_BLUE}${BOLD}${WHITE} \w ${NONE}${BOLD_NONE}$C_BLUE_BGDARKGRAY"
    PS1=$PS1"${BG_DARK_GRAY}${BOLD}${WHITE} \$ ${NONE}${BOLD_NONE}${BG_NONE}${NONE}${C_DARKGRAY} "
}

fg_branch_status

PROMPT_COMMAND+="fg_branch_status"
