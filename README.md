# Fancy Git

### Installing
```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh
```

### Uninstalling on Linux
```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/uninstall.sh | sh
```

### Uninstalling on MAC OS
```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/uninstall_mac.sh | sh
```

### After installing

1. Change your terminal font to "SourceCodePro+Powerline+Awesome+Regular". (It's necessary for rendering the icons properly)
2. Restart your terminal.

If you can't find the font, it's still possible to install it manually by running `fancygit configure-fonts`.

### About

As a picture is worth a thousand words...

![001](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/001.png)
![002](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/002.png)
![003](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/003.png)

### Commands

| Command                 | Description                                                                                  |
| ----------------------- | -------------------------------------------------------------------------------------------- |
| fancygit -h, --help     | Show the fancygit help                                                                       |
| fancygit -v, --version  | Show the fancygit version                                                                    |
| fancygit self-update    | Update fancygit code with the last release from github                                       |
| fancygit wow            | Change to powerline style. Bear in mind that it's not really powerline, just a color scheme. |

### Git suggested colors

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

I suggest you to use this scheme color because fancygit will paint the background branch according to the current repo status.

### Aliases

| Alias                    | Command                                            | Description
| ------------------------ | ---------------------------------------------------|---------------------------------------------------
| gs                       | git status                                         | Show git status.
| ga \<file\> ...          | Add files in order to commit. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/ga.sh)                                   | Add a file in order to commit.
| gaa                      | Add all files in order to commit. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gaa.sh)                                      | Add all files in order to commit.
| gd                       | clear && git diff                                  | Clear screen and git diff
| gcm                      | git commit                                         | Start committing.
| gcmm "\<message\>"       | git commit -m "\<message\>"                        | Start committing with a message.
| gpl                      | git pull                                           | Git pull.
| gps                      | git push                                           | Git push.
| gplo \<branch-name\>     | git pull origin \<branch-name\>                    | Git pull from \<branch-name\> to current local branch.
| gpso \<branch-name\>     | git push origin \<branch-name\>                    | Git push from current local branch to \<branch-name\>.
| gplob                    | Git pull from remote current branch to local current branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gplob.sh)                                       | Git pull from remote branch to local branch.
| gpsob                    | Git push from local current branch to remote current branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gpsob.sh)                                       | Git push from local branch to remote branch.
| gck \<file\> ...         | git checkout -- \<file\> [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gck.sh)                           | Rollback file changes.
| gckb \<branch-name\>     | git checkout \<branch-name\>                       | Switch to a branch.
| gckbt \<branch-name\>    | Switch to a branch with --track option. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gckbt.sh)        | Switch to a branch with --track option.
| gcb \<branch-name\>      | git checkout -b \<branch-name\>                    | Create and switch to the new branch.
| gdb \<branch-name\>      | git branch -D \<branch-name\>                      | Delete a local branch.
| gdbr \<branch-name\>     | git push origin --delete \<branch-name\>           | Delete a remote branch.
| grb \<new-branch-name\>  | Rename a local branch. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grb.sh)           | Rename current branch (local).
| grba \<new-branch-name\> | Rename a branch (local and remote). [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grba.sh)           | Rename current branch (local and remote).
| gl                       | git log                                            | Show git log.
| glp                      | Show compact git log. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/glp.sh)    | Show git log compact and allow you to filter results.
| gdof                     | find . -name "*.orig" \| xargs rm -rf              | Remove all .orig files from project.
| gfi \<file\>             | git update-index --assume-unchanged \<file\>       | Force git to ignore a file.
| gurl                     | Show git repository URL. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gurl.sh)                                       | Show git repository URL.
| guser                    | Show git user information. [file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/guser.sh)                                       | Show git user information.

### Donation

```
1Na7pB6xMYZvH9ast7aP1rhdG9J5LEXd5C
```
