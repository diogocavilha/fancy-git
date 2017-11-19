. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion

fancygit_prompt_builder() {
    # ASCII
    local separator
    local branch_icon
    local is_git_repo
    local has_untracked_files
    local has_changed_files
    local has_added_files

    # Git info
    local branch_name
    local branch_status
    local staged_files
    local git_stash
    local git_untracked_files
    local git_changed_files
    local git_has_unpushed_commits
    local git_number_unpushed_commits

    # Colors
    local none
    local bold
    local bold_none
    local bg_none
    local bg_dark_gray
    local bg_light_yellow
    local bg_white
    local bg_blue
    local bg_light_magenta
    local dark_gray
    local blue
    local black
    local white
    local light_yellow
    local light_magenta
    local light_green

    # Separator styles
    local s_yellow
    local s_white

    # Prompt style
    local user_at_host
    local user_at_host_end
    local path
    local path_git
    local path_end
    local user_symbol
    local user_symbol_end
    local branch
    local branch_end

    # Prompt format
    local prompt_user
    local prompt_path
    local prompt_symbol
    local prompt_branch

    # ASCII
    separator=""
    branch_icon=""
    is_git_repo=""
    has_git_stash=" "
    has_untracked_files=" "
    has_changed_files="  "
    has_added_files="  "
    has_unpushed_commits="  "

    # Git info
    branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    branch_status=$(git status -s 2> /dev/null)
    staged_files=$(git diff --name-only --cached 2> /dev/null)
    git_stash=$(git stash list 2> /dev/null)
    git_untracked_files=$(git ls-files --others --exclude-standard 2> /dev/null)
    git_changed_files=$(git ls-files -m 2> /dev/null)
    git_has_unpushed_commits=$(git log origin/$branch_name..HEAD 2> /dev/null)
    git_number_unpushed_commits=$(git log --pretty=oneline origin/$branch_name..HEAD 2> /dev/null | wc -l)

    # Colors
    none="\\[\\e[39m\\]"
    bold="\\[\\e[1m\\]"
    bold_none="\\[\\e[0m\\]"
    bg_none="\\[\\e[49m\\]"
    bg_dark_gray="\\[\\e[100m\\]"
    bg_light_yellow="\\[\\e[103m\\]"
    bg_light_green="\\[\\e[102m\\]"
    bg_white="\\[\\e[107m\\]"
    bg_blue="\\[\\e[44m\\]"
    bg_light_magenta="\\[\\e[105m\\]"
    dark_gray="\\[\\e[90m\\]"
    blue="\\[\\e[34m\\]"
    black="\\[\\e[30m\\]"
    white="\\[\\e[97m\\]"
    light_yellow="\\[\\e[93m\\]"
    light_magenta="\\[\\e[95m\\]"
    light_green="\\[\\e[92m\\]"

    # Separator styles
    s_darkgray_bglightmagenta="${dark_gray}${bg_light_magenta}${separator}${bg_none}${none}"
    s_lightmagenta_bgblue="${light_magenta}${bg_blue}${separator}${bg_none}${none}"
    s_blue_bgyellow="${blue}${bg_light_yellow}${separator}${bg_none}${none}${bg_none}"
    s_blue_bglightgreen="${blue}${bg_light_green}${separator}${bg_none}${none}${bg_none}"
    s_blue_bgwhite="${blue}${bg_white}${separator}${bg_none}${none}${bg_none}"
    s_yellow="${light_yellow}${separator}${none}"
    s_green="${light_green}${separator}${none}"
    s_white="${white}${separator}${none}"
    s_blue="${blue}${separator}${none}"

    # Prompt style
    user_at_host="${white}${bg_dark_gray}${bold}"
    user_at_host_end="${bold_none}${bg_none}${s_darkgray_bglightmagenta}"
    path="${bg_blue}${white}${bold}"
    path_git="${bg_blue}${white}  ${is_git_repo} ${bold}"
    path_end="${none}${bold_none}"
    user_symbol="${bg_light_magenta}${bold}${white}"
    user_symbol_end="${none}${bold_none}${bg_none}${s_lightmagenta_bgblue}"
    branch="${s_blue_bgwhite}${bg_white}${black}${bold}"
    branch_end="${bg_none}${none}${bold_none}${s_white}"

    # Building prompt
    if [ "$branch_status" != "" ]
    then
        branch="${s_blue_bgyellow}${bg_light_yellow}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_yellow}"
    fi

    if [ "$staged_files" = "" ]
    then
        has_added_files=""
    fi

    if [ "$staged_files" != "" ]
    then
        branch="${s_blue_bglightgreen}${bg_light_green}${black}${bold}"
        branch_end="${bg_none}${bold_none}${s_green}"
    fi

    if [ "$git_stash" = "" ]
    then
        has_git_stash=""
    fi

    if [ "$git_untracked_files" = "" ]
    then
        has_untracked_files=""
    fi

    if [ "$git_changed_files" = "" ]
    then
        has_changed_files=""
    fi

    has_unpushed_commits="$has_unpushed_commits+$git_number_unpushed_commits"
    if [ "$git_has_unpushed_commits" = "" ]
    then
        has_unpushed_commits=""
    fi

    prompt_user="${user_at_host}\\u@\\h ${user_at_host_end}"
    prompt_symbol="${user_symbol} \$ ${user_symbol_end}"
    prompt_path="${path}${bold}${white} \\w ${path_end}${s_blue}"

    if [ "$branch_name" != "" ]
    then
        prompt_path="${path_git}${has_unpushed_commits}${has_git_stash}${has_untracked_files}${has_changed_files}${has_added_files} \\w ${path_end}"
        prompt_branch="${branch} ${branch_icon} ${branch_name} ${branch_end}"
        PS1="${prompt_user}${prompt_symbol}${prompt_path}${prompt_branch} "
        return
    fi

    PS1="${prompt_user}${prompt_symbol}${prompt_path} "
}

PROMPT_COMMAND="fancygit_prompt_builder"
