[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/diogocavilha/fancy-git)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://github.com/diogocavilha/fancy-git/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![GitHub forks](https://img.shields.io/github/forks/diogocavilha/fancy-git.svg)](https://gitHub.com/diogocavilha/fancy-git/)
[![GitHub stars](https://img.shields.io/github/stars/diogocavilha/fancy-git.svg)](https://GitHub.com/diogocavilha/fancy-git/stargazers/)
[![GitHub contributors](https://img.shields.io/github/contributors/diogocavilha/fancy-git.svg)](https://gitHub.com/diogocavilha/fancy-git/graphs/contributors/)

![logo](https://github.com/diogocavilha/fancy-git/blob/master/images/logo.png)

That's a prompt changer to show a few cool git informations about your repository on terminal.

[You can check out the changelog here](https://github.com/diogocavilha/fancy-git/blob/master/CHANGELOG.md)

### Installing (Linux and MAC OS)
```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh
```

### Uninstalling (Linux and MAC OS)
```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/uninstall.sh | sh
```

### After installing

1. Change your terminal font to "SourceCodePro+Powerline+Awesome+Regular". (It's necessary for rendering the icons properly)
2. Restart your terminal.

If you can't find the font, it's still possible to install it manually by running `fancygit configure-fonts` or even installing the ttf file placed at `~/.fancy-git/fonts/SourceCodePro+Powerline+Awesome+Regular.ttf`.

### Overview

As a picture is worth a thousand words...

**Default mode**

![001](https://github.com/diogocavilha/fancy-git/blob/master/images/default_001.png)
![002](https://github.com/diogocavilha/fancy-git/blob/master/images/default_002.png)
![003](https://github.com/diogocavilha/fancy-git/blob/master/images/default_003.png)
![004](https://github.com/diogocavilha/fancy-git/blob/master/images/default_004.png)
![005](https://github.com/diogocavilha/fancy-git/blob/master/images/default_005.png)
![006](https://github.com/diogocavilha/fancy-git/blob/master/images/default_006.png)
![007](https://github.com/diogocavilha/fancy-git/blob/master/images/default_007.png)

> In case you are in doubt about what some icon means, you can type `fancygit -h` or `fancygit --help`.

**Simple mode**

If you're running it on a server and you don't want to be too "fancy", you can choose using the simple mode.

> Once you're using the simple mode, it'll not show you lots of cool informations about the git repository. The only information it'll give you is the branch name and whether or not it has changes.

In order to change to the **simple mode** you can type `fancygit simple`. And if you want to return to the **default mode** (colored), you can type `fancygit default`.

![001](https://github.com/diogocavilha/fancy-git/blob/master/images/001.png)
![002](https://github.com/diogocavilha/fancy-git/blob/master/images/002.png)
![003](https://github.com/diogocavilha/fancy-git/blob/master/images/003.png)

### Commands

| Command                  | Description
| ------------------------ | ---------------------------------------------------------
| fancygit -h, --help      | Show this help.
| fancygit -v, --version   | Show the fancygit version.
| fancygit update          | Update fancygit code with the last release from github.
| fancygit configure-fonts | Install font in order to render icons properly. (only for colored styles).

### Styles

| Command                     | Description
| --------------------------- | ---------------------------------------------------------
| fancygit simple             | Change prompt to the simple style.
| fancygit simple-double-line | Change prompt to the simple style in double line.
| fancygit default            | Change prompt to the default (colored) style. (This is the fallback style).
| fancygit double-line        | Change prompt to the default (colored) style in double line.
| fancygit human              | Change prompt to the human readable style.
| fancygit dark               | Change prompt to the dark style.
| fancygit dark-double-line   | Change prompt to the dark style in double line.
| fancygit light              | Change prompt to the light style.
| fancygit light-double-line  | Change prompt to the light style in double line.

### Git suggested colors

Color configuration to put on your `~/.gitconfig` file.

```bash
[color]
    ui = auto
[color "diff"]
    meta = cyan bold
    old = magenta bold
    new = green bold
[color "status"]
    added = green bold
    changed = yellow
    untracked = cyan
```

I suggest you to use this scheme color because fancygit will paint the background branch or showing icon colors according to the current repo status.

### Aliases

| Alias                    | Command                                                                                                                                                | Description
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------
| gs                         | git status                                                                                                                                             | Show git status.
| ga \<file\> [<other_file>] | Add files in order to commit. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/ga.sh)                                      | Add a file in order to commit.
| gap \<file\>               | Add part of a files in order to commit.                                                                                                                | Add a file in order to commit.
| gaa                        | Add all files in order to commit. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gaa.sh)                                 | Add all files in order to commit.
| gd                         | Show changes of a file and suggests to add it. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gd.sh)                     | Clear screen and git diff
| gcm                        | git commit                                                                                                                                             | Start committing.
| gcmm "\<message\>"         | git commit -m "\<message\>"                                                                                                                            | Start committing with a message.
| gpl                        | git pull. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gpl.sh)                                                         | Git pull.
| gps                        | git push                                                                                                                                               | Git push.
| gplo \<branch-name\>       | git pull origin \<branch-name\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gplo.sh)                                  | Git pull from \<branch-name\> to current local branch.
| gpso \<branch-name\>       | git push origin \<branch-name\>                                                                                                                        | Git push from current local branch to \<branch-name\>.
| gplob                      | Git pull from remote current branch to local current branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gplob.sh)    | Git pull from remote branch to local branch.
| gpsob                      | Git push from local current branch to remote current branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gpsob.sh)    | Git push from local branch to remote branch.
| gck \<file\> ...           | git checkout -- \<file\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gck.sh)                                          | Rollback file changes.
| gckb \<branch-name\>       | git checkout \<branch-name\>                                                                                                                           | Switch to a branch.
| gckbt \<branch-name\>      | Switch to a branch with --track option. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gckbt.sh)                         | Switch to a branch with --track option.
| gcb \<branch-name\>        | git checkout -b \<branch-name\>                                                                                                                        | Create and switch to the new branch.
| gdb \<branch-name\>        | git branch -D \<branch-name\>                                                                                                                          | Delete a local branch.
| gdbr \<branch-name\>       | git push origin --delete \<branch-name\>                                                                                                               | Delete a remote branch.
| grb \<new-branch-name\>    | Rename a local branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grb.sh)                                            | Rename current branch (local).
| grba \<new-branch-name\>   | Rename a branch (local and remote). [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grba.sh)                              | Rename current branch (local and remote).
| gl                         | git log                                                                                                                                                | Show git log.
| glp                        | Show pretty git log. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/glp.sh)                                              | Show pretty git log.
| gdof                       | find . -name "*.orig" \| xargs rm -rf                                                                                                                  | Remove all .orig files from project.
| gfi \<file\>               | git update-index --assume-unchanged \<file\>                                                                                                           | Force git to ignore a file.
| gurl                       | Show git repository URL. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gurl.sh)                                         | Show git repository URL.
| guser                      | Show git user information. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/guser.sh)                                      | Show git user information.
| gst                        | git stash                                                                                                                                              | Create new stash with default message.
| gstl                       | git stash list                                                                                                                                         | List all stashes.
| gstm                       | git stash save "\<message\>"                                                                                                                           | Create new stash with custom message.
| gstw                       | git stash show \<stash_id\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gstw.sh)                                      | Show stash diffs.
| gsta                       | git stash apply \<stash_id\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gsta.sh)                                     | Apply stash.
| gstd                       | git stash drop \<stash_id\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gstd.sh)                                      | Drop specific stash.
| gg "\<message\>"           | git add --all && git commit -m "\<message\>" && git push [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gg.sh)           | Add all changes, then commit and push them.
| gu \<file\> [<other_file>] | git reset HEAD \<file\>                                                                                                                                | Remove files from staging area.

That's the beginning of the project. It could be better and it will, I promiss it.

If you have any problem on setting up the fancy-git, contact me at [diogocavilha@gmail.com](mailto:diogocavilha@gmail.com) or simply create an issue. I'll be happy to help you.

[![Donate_with_PayPal](https://github.com/diogocavilha/fancy-git/blob/master/images/buymeacoffee.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=QFCN8W7PRX696&lc=BR&item_name=diogocavilha%2fFancyGit&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)
