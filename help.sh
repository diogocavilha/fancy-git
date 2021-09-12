#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   11.18.2017
#
# It prints the help text.

echo " Fancy Git v$FANCYGIT_VERSION - $(date +%Y) by Diogo Alexsander Cavilha <diogocavilha@gmail.com>.
 FanycGit is a prompt changer to show you a few cool git informations about the repository on terminal.

 CORE COMMANDS

 fancygit -h, --help                    Show this help.
 fancygit -v, --version                 Show the FancyGit version.
 fancygit --update                      Update FancyGit code with the last release from Github.
 fancygit --fonts-install               Install font in order to render icons/symbols properly.
 fancygit --colors                      Show color scheme to use on git management process, like on \"git status\" command.
 fancygit --colors-apply                Apply the color scheme.
 fancygit --config-list                 Show FancyGit config.
 fancygit --config-reset                Reset the configuration as if you have just installed FancyGit.

 FEATURE COMMANDS

 fancygit --enable-full-path            Show the entire path.
 fancygit --disable-full-path           Show only the the directory name you are working on. Not the entire path.
 fancygit --enable-time                 Show current time.
 fancygit --disable-time                Hide current time.
 fancygit --enable-double-line          Show a double line prompt.
 fancygit --disable-double-line         Show a single line prompt.
 fancygit --enable-rich-notification    Show notification area with icons.
 fancygit --disable-rich-notification   Show notification area with simple symbols.

 SEPARATOR STYLE COMMANDS

 fancygit --separator-default           Change the separator (if it's present on current theme) to default style.
 fancygit --separator-blocs             Change the separator (if it's present on current theme) to blocs style.
 fancygit --separator-blocs-tiny        Change the separator (if it's present on current theme) to blocs-tiny style.
 fancygit --separator-curve             Change the separator (if it's present on current theme) to curve style.
 fancygit --separator-fire              Change the separator (if it's present on current theme) to fire style.
 fancygit --separator-lego              Change the separator (if it's present on current theme) to lego style.
 fancygit --separator-paint             Change the separator (if it's present on current theme) to paint style.

 THEME COMMANDS

 fancygit --theme-default               Change prompt to the default theme.
 fancygit --theme-human                 Change prompt to the human theme readable theme.
 fancygit --theme-simple                Change prompt to the simple theme.

 COLOR SCHEME COMMANDS

 fancygit --color-scheme-simple         Available for theme-simple.
 fancygit --color-scheme-human          Available for theme-human.
 fancygit --color-scheme-default        Available for theme-default.
 fancygit --color-scheme-dracula        Available for theme-default.
 fancygit --color-scheme-dark           Available for theme-default.
 fancygit --color-scheme-dark-col       Available for theme-default.
 fancygit --color-scheme-light          Available for theme-default.

 ICONS MEANING

    = The current directory is a git repository.
    = There are untracked files.
    = There are modified files.
    = There are added files waiting to be committed.
    = There are stashes.
    = There are commits waiting to be pushed.
    = Branch icon.
    = Current branch exists only locally.
    = Current branch has been merged into master branch.
    = You are working on a Python virtual environment.

 ICONS MEANING FOR SIMPLE STYLE

  ?  = There are untracked files.
  +- = There are modified files.
  ✔  = There are added files waiting to be committed.
  ∿  = There are stashes.
  N^ = There are N commits waiting to be pushed.
  *  = Current branch exists only locally.
  <  = Current branch has been merged into master branch.

  If a branch name is followed by an asterisk (*), it means that the branch exists only locally.

 ALIASES

 gs                         Show git status.
 ga <file> [<other_file>]   Add files in order to commit.
 gap <file>                 Add part of a file in order to commit.
 gaa                        Add all files in order to commit.
 gd                         Clear screen and git diff.
 gcm                        Start committing.
 gcmm \"message\"             Start committing with a message.
 gpl                        Git pull.
 gps                        Git push.
 gplo <branch-name>         Git pull from <branch-name> to current local branch.
 gpso <branch-name>         Git push from current local branch to <branch-name>.
 gplob                      Git pull from remote current branch to local current branch.
 gpsob                      Git push from local current branch to remote current branch.
 gck <file> [<other_file>]  Rollback file changes.
 gckb <branch-name>         Switch to a branch.
 gckbt <branch-name>        Switch to a branch with --track option.
 gcb <branch-name>          Create and switch to the new branch.
 gdb <branch-name>          Delete a local branch.
 gdbr <branch-name>         Delete a remote branch.
 grb <new-branch-name>      Rename a local branch.
 grba <new-branch-name>     Rename a branch (local and remote).
 gl                         Show git log.
 glp                        Show compact git log.
 gdof                       Remove all .orig files from project.
 gfi                        Ignore a file even if this one has already been tracked.
 gurl                       Show git repository URL.
 guser                      Show git user information.
 glp                        Show pretty git log.
 gst                        Create new stash with default message.
 gstl                       List all stashes.
 gstm \"message\"             Create new stash with custom message.
 gstw <stash_id>            Show stash diffs by its numeric ID.
 gsta <stash_id>            Apply stash by its numeric ID.
 gstd <stash_id>            Drop a specific stash by its numeric ID.
 gg \"message\"               Add all changes, then commit and push them.
 gu <file> [<other_file>]   Remove files from staging area.
 pve                        Show the current Python virtual environment name.

 By: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
 Date: 02.28.2016
 Source code available at: <https://github.com/diogocavilha/fancy-git>
"
