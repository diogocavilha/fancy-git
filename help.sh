#!/bin/bash

. ~/.fancy-git/version.sh

fg_current_year=$(date +%Y)

echo " Fancy Git v$FANCYGIT_VERSION (c) $fg_current_year by Diogo Alexsander Cavilha <diogocavilha@gmail.com>.
 Prompt changer to show a few cool git informations about your repository on terminal.

 COMMANDS

 fancygit -h, --help        Show this help.
 fancygit -v, --version     Show the fancygit version.
 fancygit update            Update fancygit code with the last release from github.
 fancygit simple            Change prompt to simple mode.
 fancygit default           Change prompt to default (colored) mode.
 fancygit configure-fonts   Install font in order to render icons properly.

 ICONS MEANING

    = The current directory is a git repository.
    = There are untracked files.
    = There are modified files.
    = There are added files waiting to be committed.
    = There are stashes.
    = There are commits waiting to be pushed.

 ALIASES

 gs                         Show git status.
 ga <file> [<other_file>]   Add files in order to commit.
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

 By: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
 Date: 02.28.2016
 Source code available at: <https://github.com/diogocavilha/fancy-git>
"
