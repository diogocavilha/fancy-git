#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   09.10.2021
#
# Git manager - Git functions provider. It encapsulates common git expression commands.

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
    local icon_local_branch="${FANCYGIT_ICON_LOCAL_BRANCH:-}"
    local icon_local_remote_branch="${FANCYGIT_ICON_LOCAL_REMOTE_BRANCH:-}"
    local icon_merged_branch="${FANCYGIT_ICON_MERGED_BRANCH:-}"

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