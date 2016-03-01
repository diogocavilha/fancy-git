#============================================================
# GENERAL CONFIGURATION
#============================================================

CONFIG_GIT_BRANCH_SHOW="true"
CONFIG_GIT_BRANCH_DELIMITERS[0]=""
CONFIG_GIT_BRANCH_DELIMITERS[1]=""
CONFIG_GIT_BRANCH_SHOW_ICON="true"
CONFIG_GIT_BRANCH_ICON_DELIMITERS[0]=""
CONFIG_GIT_BRANCH_ICON_DELIMITERS[1]=""
CONFIG_GIT_BRANCH_ICON_CHANGED="●"   # icons: ●, ✖, ✔
CONFIG_GIT_BRANCH_ICON_UNCHANGED="●" # icons: ●, ✖, ✔
CONFIG_GIT_FUNCTIONS_COLOR="true"
CONFIG_PS1_STYLE="1"
CONFIG_PS1_COLOR="false"

#------------------------------------------------------------

# Font colors
DEFAULT_COLOR=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BOLD_RED=$(tput bold; tput setaf 1)
BOLD_GREEN=$(tput bold; tput setaf 2)
BOLD_YELLOW=$(tput bold; tput setaf 3)
BOLD_BLUE=$(tput bold; tput setaf 4)

alias bash.reload=". ~/.bashrc"

#------------------------------------------------------------
# Shows an icon informing whether the branch has changes.
#------------------------------------------------------------
git_branch_status() {
    local icon=""
    local branch_status=$(git status -s 2> /dev/null)

    icon=${CONFIG_GIT_BRANCH_ICON_DELIMITERS[0]}$CONFIG_GIT_BRANCH_ICON_UNCHANGED${CONFIG_GIT_BRANCH_ICON_DELIMITERS[1]}

    if [ "$CONFIG_GIT_FUNCTIONS_COLOR" = "true" ]; then
        icon="$GREEN$icon$DEFAULT_COLOR"
    fi

    if [ "$branch_status" != "" ]; then
        icon=${CONFIG_GIT_BRANCH_ICON_DELIMITERS[0]}$CONFIG_GIT_BRANCH_ICON_CHANGED${CONFIG_GIT_BRANCH_ICON_DELIMITERS[1]}

        if [ "$CONFIG_GIT_FUNCTIONS_COLOR" = "true" ]; then
            icon="$RED$icon$DEFAULT_COLOR"
        fi
    fi

    echo -e $icon
}

#------------------------------------------------------------
# Shows the git branch name.
#------------------------------------------------------------
git_parse_branch() {
    local branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    local branch_full_info=""

    if [ "$branch_name" != "" ] && [ "$CONFIG_GIT_BRANCH_SHOW" = "true" ]; then
        if [ "$CONFIG_GIT_BRANCH_SHOW_ICON" = "true" ]; then
            if [ "$CONFIG_PS1_STYLE" = "1" ]; then
                branch_name="$branch_name $(git_branch_status) "
            else
                branch_name="$branch_name $(git_branch_status)"
            fi
        fi

        branch_full_info="$DEFAULT_COLOR${CONFIG_GIT_BRANCH_DELIMITERS[0]}$branch_name${CONFIG_GIT_BRANCH_DELIMITERS[1]}"

        if [ "$CONFIG_GIT_FUNCTIONS_COLOR" = "true" ]; then
            branch_full_info="$YELLOW${CONFIG_GIT_BRANCH_DELIMITERS[0]}$branch_name$YELLOW${CONFIG_GIT_BRANCH_DELIMITERS[1]}$DEFAULT_COLOR"
        fi

        if [ "$CONFIG_PS1_STYLE" = "1" ]; then
            branch_full_info=$branch_full_info
        fi
    fi

    echo -e $branch_full_info
}

PS1="\e]0;\[\u\]@\[\h\]\[:\] \[\w\]\[\a\]\[${debian_chroot:+($debian_chroot)}\]\[\u\]@\[\h\]\[:\]\[\w\]\[\$\] "
PS1="$PS1\$(git_parse_branch)"

if [ "$CONFIG_PS1_COLOR" = "true" ]; then
    PS1="$BOLD_GREEN\[\u\]$BOLD_YELLOW@$BOLD_GREEN\[\h\]$BOLD_YELLOW:\[\w\]\[\$\]$DEFAULT_COLOR $(git_parse_branch)"
fi

case $CONFIG_PS1_STYLE in
    "1")
        PS1="$PS1"
    ;;
    "2")
        PS1="[\u]@[${HOSTNAME%%.*}]: \w \$(git_parse_branch) \n\\$ "
        if [ "$CONFIG_PS1_COLOR" = "true" ]; then
            PS1="$BOLD_RED[$BOLD_GREEN\u$BOLD_RED]$BOLD_YELLOW@$BOLD_RED[$BOLD_GREEN${HOSTNAME%%.*}$BOLD_RED]$BOLD_YELLOW:$BOLD_YELLOW \w $BOLD_BLUE\$(git_parse_branch) \n$BOLD_GREEN\\$ $DEFAULT_COLOR"
        fi
    ;;
    "3")
        PS1="┌─[\h][\w] \\$ \$(git_parse_branch)\n└─╼ "
        if [ "$CONFIG_PS1_COLOR" = "true" ]; then
            PS1="$BOLD_RED┌─[$BOLD_GREEN\h$BOLD_RED][$BOLD_GREEN\w$BOLD_RED] $BOLD_YELLOW\\$ \$(git_parse_branch)\n$BOLD_RED└─╼ $DEFAULT_COLOR"
        fi
    ;;
    "4")
        PS1="┌─[\u]──[${HOSTNAME%%.*}]: \w \\$ \$(git_parse_branch)\n└──>> "
        if [ "$CONFIG_PS1_COLOR" = "true" ]; then
            PS1="$BOLD_RED┌─[$BOLD_GREEN\u$BOLD_RED]──[$BOLD_GREEN${HOSTNAME%%.*}$BOLD_RED]: $BOLD_YELLOW\w \\$ \$(git_parse_branch)\n$BOLD_RED└──>> $DEFAULT_COLOR"
        fi
    ;;
    "5")
        PS1="┌─ \u | ${HOSTNAME%%.*}: \w \\$ \$(git_parse_branch)\n└──> "
        if [ "$CONFIG_PS1_COLOR" = "true" ]; then
            PS1="$BOLD_RED┌─ $BOLD_GREEN\u$BOLD_RED | $BOLD_GREEN${HOSTNAME%%.*}$BOLD_RED : $BOLD_YELLOW\w \\$ \$(git_parse_branch)\n$BOLD_RED└──> $DEFAULT_COLOR"
        fi
    ;;
    *)
        PS1="$PS1"
    ;;
esac
