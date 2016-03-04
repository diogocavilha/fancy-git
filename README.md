# Fancy Git

### Installing
```sh
git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git && echo ". ~/.fancy-git/main.sh" >> ~/.bashrc && . ~/.bashrc
```

### About

As a picture is worth a thousand words...

![001](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/001.png)
![002](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/002.png)
![003](https://github.com/diogocavilha/fancy-git/blob/master/screenshots/003.png)

### Commands

| Command                 | Description                                               |
| ------------------      | --------------------------------------------------------- |
| fancygit -h, --help     | Show the fancygit help                                    |
| fancygit -v, --version  | Show the fancygit version                                 |
| fancygit self-update    | Update fancygit code with the last release from github    |

### Aliases

| Alias                | Command                                            | Description
| -------------------- | ---------------------------------------------------|---------------------------------------------------
| gs                   | git status                                         | Show git status.
| ga \<file\>          | git add \<file\>                                   | Add a file in order to commit.
| gaa                  | git add --all                                      | Add all files in order to commit.
| gd                   | clear && git diff                                  | Clear screen and git diff
| gcm                  | git commit                                         | Start committing.
| gck \<file\>         | git checkout -- \<file\>                           | Rollback file changes.
| gcb                  | git checkout -b [branch-name]                      | Create and switch to the new branch.
| gdb                  | git branch -D [branch-name]                        | Delete a local branch.
| gdbr \<branch-name\> | git push origin --delete \<branch-name\>           | Delete a remote branch.
| gl                   | git log                                            | Show git log.
| glp                  | git log --pretty=oneline                           | Show git log compact.
| gdof                 | find . -name "*.orig" | xargs rm -rf               | Removes all .orig files from project.
| gfi \<file\>         | git update-index --assume-unchanged \<file\>       | Force git to ignore a file.
