#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   09.10.2021

# ----------------------------------------------------------------------------------------------------------------------
# Checks if the given branch name is local only.
#
# param string $1 Branch name.
#
# return int 0: The given branch name is local only.
# return int 1: The given branch name is local and remote.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_is_only_local_branch() {
    local param_branch_name="$1"
    local is_only_local_branch

    is_only_local_branch=$(git branch -r 2> /dev/null | grep -c "$param_branch_name")

    if [ 0 -eq "$is_only_local_branch" ]
    then
        return 0
    fi

    return 1
}

# ----------------------------------------------------------------------------------------------------------------------
# Returns the branch icon according to the given branch name.
# It returns different icons for a local only branch and a local/remote one.
#
# param string $1 Branch name.
#
# return string Branch icon.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_branch_icon() {
    local param_branch_name="$1"
    local icon_local_branch=""
    local icon_local_remote_branch=""
    local icon_merged_branch=""

    if fancygit_git_is_only_local_branch "$param_branch_name"
    then
        echo "$icon_local_branch"
        return
    fi

    if fancygit_git_is_merged_branch
    then
        echo "$icon_merged_branch"
        return
    fi

    echo "$icon_local_remote_branch"
}

# ----------------------------------------------------------------------------------------------------------------------
# Checks if the current branch is has been merged already.
#
# return int 0 Branch has been merged.
# return int 1 Branch has not been merged.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_is_merged_branch() {
    local branch
    local merged_branch=""

    branch=$(fancygit_git_get_branch)

    # We don't need to check if branch is merged when it is one of: master, develop, main.
    # Since we assume they could be already the "main branch".
    # It might cause some trouble when we have a develop branch which is not the main one.
    case "$branch" in
        "master"|"develop"|"main") return 1;;
    esac

    merged_branch=$(git branch -r --merged master 2> /dev/null | grep "$branch" 2> /dev/null)
    if [ "" != "$merged_branch" ]
    then
        return 0
    fi

    merged_branch=$(git branch -r --merged develop 2> /dev/null | grep "$branch" 2> /dev/null)
    if [ "" != "$merged_branch" ]
    then
        return 0
    fi

    merged_branch=$(git branch -r --merged main 2> /dev/null | grep "$branch" 2> /dev/null)
    if [ "" != "$merged_branch" ]
    then
        return 0
    fi

    return 1
}

# ----------------------------------------------------------------------------------------------------------------------
# Get git status.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_status() {
    git status -s 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git diff to check staged files and return the output.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_staged_files() {
    git diff --name-only --cached 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get current branch name.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get a list of stashes.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_stash() {
    git stash list 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get untracked files.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_untracked_files() {
    git ls-files --others --exclude-standard 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get a list of changed files.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_changed_files() {
    git ls-files -m 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get remote branch name.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_git_get_remote_branch() {
    local branch_name

    branch_name=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null | cut -d"/" -f1)
    branch_name=${branch_name:-origin}
    echo "$branch_name"
}

# ----------------------------------------------------------------------------------------------------------------------
# Performs a git ls-files to check changed files and return the output.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_get_unpushed_commits() {
    local branch_name
    local remote_name

    branch_name=$(fancygit_git_get_branch)
    remote_name=$(__fancygit_git_get_remote_branch)
    git log --pretty=oneline "${remote_name}"/"${branch_name}"..HEAD 2> /dev/null
}

# ----------------------------------------------------------------------------------------------------------------------
# Get the notification area according to the parameter.
#
# param int 0: Poor notification area, no icons.
# param int 1: Rich notification area, icons instead of simples characters.
# return string Notification area.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_notification_area() {
    if [ "false" = "$1" ]
    then
        __fancygit_get_poor_notification_area
        return
    fi

    __fancygit_get_rich_notification_area
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a rich notification area, which means it will have the same icons as fancy themes.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_rich_notification_area() {
    local icon_git_stash=" "
    local icon_untracked_files="  "
    local icon_changed_files="  "
    local icon_added_files="  "
    local icon_unpushed_commits="  "
    local number_unpushed_commits=0
    local venv=""

    if [ "" = "$(fancygit_git_get_staged_files)" ]
    then
        icon_added_files=""
    fi

    if [ "" = "$(fancygit_git_get_stash)" ]
    then
        icon_git_stash=""
    fi

    if [ "" = "$(fancygit_git_get_untracked_files)" ]
    then
        icon_untracked_files=""
    fi

    if [ "" = "$(fancygit_git_get_changed_files)" ]
    then
        icon_changed_files=""
    fi

    number_unpushed_commits=$(fancygit_git_get_unpushed_commits | wc -l)
    icon_unpushed_commits="${icon_unpushed_commits}+${number_unpushed_commits}"
    if [ 0 -eq "$number_unpushed_commits" ]
    then
        icon_unpushed_commits=""
    fi

    venv=$(__fancygit_get_venv_icon)
    notification_area="${venv}${icon_git_stash}${icon_untracked_files}${icon_changed_files}${icon_added_files}${icon_unpushed_commits}"

    echo "$notification_area "
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a poor notification area, which means it won't have icons.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_poor_notification_area() {
    local notification_area=""

    # Set colors.
    local color_reset="\\[\\e[39m\\]"
    local color_cyan="\\[\\e[36m\\]"
    local color_light_green="\\[\\e[92m\\]"
    local color_light_red="\\[\\e[91m\\]"

    # Git info.
    local branch_name
    local staged_files
    local git_stash
    local git_has_unpushed_commits
    local git_number_unpushed_commits
    local git_number_untracked_files
    local git_number_changed_files

    # Set git info.
    branch_name=$(fancygit_git_get_branch)
    staged_files=$(fancygit_git_get_staged_files)
    git_stash=$(fancygit_git_get_stash)
    git_has_unpushed_commits=$(fancygit_git_get_unpushed_commits)
    git_number_unpushed_commits=$(fancygit_git_get_unpushed_commits | wc -l)
    git_number_untracked_files=$(fancygit_git_get_untracked_files | wc -l)
    git_number_changed_files=$(fancygit_git_get_changed_files | wc -l)

    if [ "" != "$git_stash" ]
    then
        notification_area="${notification_area}∿${color_reset} "
    fi

    if [ "$git_number_untracked_files" -gt 0 ]
    then
        notification_area="${notification_area}${color_cyan}?${color_reset} "
    fi

    if [ "$git_number_changed_files" -gt 0 ]
    then
        notification_area="${notification_area}${color_light_green}+${color_reset}${color_light_red}-${color_reset} "
    fi

    if [ "" != "$staged_files" ]
    then
        notification_area="${notification_area}${color_light_green}✔${color_reset} "
    fi

    if [ "$git_has_unpushed_commits" ]
    then
        notification_area="${notification_area}${color_light_green}^${git_number_unpushed_commits}${color_reset} "
    fi

    if [ "" != "$branch_name" ] && fancygit_git_is_only_local_branch "$branch_name"
    then
        notification_area="${notification_area}${color_light_green}*${color_reset} "
    fi

    if fancygit_git_is_merged_branch
    then
        notification_area="${notification_area}${color_light_green}<${color_reset} "
    fi

    if [ "" != "$notification_area" ]
    then
        # Trim notification_area content
        notification_area=$(echo "$notification_area" | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//')
        echo " [ $notification_area ] "
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the icon that indicates we're working in a virtual environment.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_get_venv_icon() {
    local icon_venv

    icon_venv=" "

    if ! [ -z $VIRTUAL_ENV ] || ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z $CONDA_DEFAULT_ENV ])
    then
        echo "$icon_venv"
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Return the virtual environment name if it exists.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_get_venv_name() {
    if ! [ -z ${VIRTUAL_ENV} ]
    then
        echo "($(basename \"$VIRTUAL_ENV\")) "
        return
    fi

    if ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ])
    then
        echo "($(basename \"$CONDA_DEFAULT_ENV\")) "
        return
    fi

    echo ""
}

# ----------------------------------------------------------------------------------------------------------------------
# Show suggested global git config.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_show_suggested_git_config() {
    echo "
git config --global color.ui true

git config --global color.diff.meta \"yellow bold\"
git config --global color.diff.old \"red bold\"
git config --global color.diff.new \"green bold\"
git config --global color.status.added \"green bold\"
git config --global color.status.changed \"yellow\"
git config --global color.status.untracked \"cyan\"
"
}

# ----------------------------------------------------------------------------------------------------------------------
# Apply the suggested global git config.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_git_suggested_git_config_apply() {
    `git config --global color.ui true`
    `git config --global color.diff.meta "yellow bold"`
    `git config --global color.diff.old "red bold"`
    `git config --global color.diff.new "green bold"`
    `git config --global color.status.added "green bold"`
    `git config --global color.status.changed "yellow"`
    `git config --global color.status.untracked "cyan"`
}