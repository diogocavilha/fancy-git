. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

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

user_at_host="${white}${bg_dark_gray}${bold}"
user_at_host_end="${bold_none}${bg_none}"
background_path="$bg_blue"
background_user_symbol="$bg_dark_gray"

separator=""

s_darkgray_bgblue="${dark_gray}${bg_blue}${separator}${bg_none}${none}"
s_blue_bgdarkgray="${blue}${bg_dark_gray}${separator}${bg_none}${none}${bg_none}"
s_darkgray_bgyellow="${dark_gray}${bg_light_yellow}${separator}${bg_none}${none}"
s_darkgray_bgwhite="${dark_gray}${bg_white}${separator}${bg_none}${none}"
s_darkgray="${dark_gray}${separator}${none}"
s_yellow="${light_yellow}${separator}${none}"
s_white="${white}${separator}${none}"

fg_prompt_builder() {
    local branch
    local branch_end
    local branch_name
    local branch_status

    branch="${s_darkgray_bgwhite}${bg_white}${black}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_white}"
    branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    branch_status=$(git status -s 2> /dev/null)

    if [ "$branch_status" != "" ]
    then
        branch="${s_darkgray_bgyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_yellow}"
    fi

    PS1="${user_at_host}\\u@\\h ${user_at_host_end}${s_darkgray_bgblue}"
    PS1=$PS1"${background_path}${bold}${white} \\w ${none}${bold_none}$s_blue_bgdarkgray"

    if [ "$branch_name" != "" ]
    then
        PS1=$PS1"${background_user_symbol}${bold}${white} \$ ${none}${bold_none}${bg_none}${none}"
        PS1=$PS1"${branch} ${branch_name} ${branch_end} "
        return
    fi

    PS1=$PS1"${background_user_symbol}${bold}${white} \$ ${none}${bold_none}${bg_none}${none}${s_darkgray} "
}

fg_prompt_builder

PROMPT_COMMAND="fg_prompt_builder"
