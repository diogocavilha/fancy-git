. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

fancygit_prompt_builder() {
    # ASCII
    local separator
    local branch_icon

    # Git info
    local branch_name
    local branch_status

    # Colors
    local none
    local bold
    local bold_none
    local bg_none
    local bg_dark_gray
    local bg_light_yellow
    local bg_white
    local bg_blue
    local dark_gray
    local blue
    local black
    local white
    local light_yellow

    # Separator styles
    local s_darkgray_bgblue
    local s_blue_bgdarkgray
    local s_darkgray_bgyellow
    local s_darkgray_bgwhite
    local s_darkgray
    local s_yellow
    local s_white

    # Prompt style
    local user_at_host
    local user_at_host_end
    local path
    local path_end
    local user_symbol
    local user_symbol_end
    local user_symbol_end_and_git
    local branch
    local branch_end

    # ASCII
    separator=""
    branch_icon=""

    # Git info
    branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    branch_status=$(git status -s 2> /dev/null)

    # Colors
    none="\\[\\e[39m\\]"
    bold="\\[\\e[1m\\]"
    bold_none="\\[\\e[0m\\]"
    bg_none="\\[\\e[49m\\]"
    bg_dark_gray="\\[\\e[100m\\]"
    bg_light_yellow="\\[\\e[103m\\]"
    bg_white="\\[\\e[107m\\]"
    bg_blue="\\[\\e[44m\\]"
    dark_gray="\\[\\e[90m\\]"
    blue="\\[\\e[34m\\]"
    black="\\[\\e[30m\\]"
    white="\\[\\e[97m\\]"
    light_yellow="\\[\\e[93m\\]"

    # Separator styles
    s_darkgray_bgblue="${dark_gray}${bg_blue}${separator}${bg_none}${none}"
    s_blue_bgdarkgray="${blue}${bg_dark_gray}${separator}${bg_none}${none}${bg_none}"
    s_darkgray_bgyellow="${dark_gray}${bg_light_yellow}${separator}${bg_none}${none}"
    s_darkgray_bgwhite="${dark_gray}${bg_white}${separator}${bg_none}${none}"
    s_darkgray="${dark_gray}${separator}${none}"
    s_yellow="${light_yellow}${separator}${none}"
    s_white="${white}${separator}${none}"

    # Prompt style
    user_at_host="${white}${bg_dark_gray}${bold}"
    user_at_host_end="${bold_none}${bg_none}${s_darkgray_bgblue}"
    path="${bg_blue}${bold}${white}"
    path_end="${none}${bold_none}${s_blue_bgdarkgray}"
    user_symbol="${bg_dark_gray}${bold}${white}"
    user_symbol_end="${none}${bold_none}${bg_none}${s_darkgray}"
    user_symbol_end_and_git="${none}${bold_none}${bg_none}"
    branch="${s_darkgray_bgwhite}${bg_white}${black}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_white}"

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${s_darkgray_bgyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_yellow}"
    fi

    PS1="${user_at_host}\\u@\\h ${user_at_host_end}"
    PS1=$PS1"${path}${bold}${white} \\w ${path_end}"

    if [ "$branch_name" != "" ]
    then
        PS1=$PS1"${user_symbol} \$ ${user_symbol_end_and_git}"
        PS1=$PS1"${branch} ${branch_icon} ${branch_name} ${branch_end} "
        return
    fi

    PS1=$PS1"${user_symbol} \$ ${user_symbol_end} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
