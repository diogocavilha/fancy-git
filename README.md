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

| Command                 | Description                                                |
| ------------------      | ---------------------------------------------------------- |
| fancygit -h, --help     | Shows the fancygit help                                    |
| fancygit -v, --version  | Shows the fancygit version                                 |
| fancygit self-update    | Updates fancygit code with the last release from github    |

### Aliases

| Alias                | Description                                                |
| -------------------- | ---------------------------------------------------------- |
| gs                   | git status                                                 |
| ga                   | git add [file]                                             |
| gaa                  | git add --all                                              |
| gd                   | clear screen and git diff                                  |
| gcm                  | git commit                                                 |
| gck                  | git checkout -- [file]                                     |
| gl                   | git log                                                    |
| glp                  | git log --pretty=oneline                                   |
| gremove.origfiles    | Removes all .orig files from project                       |
| gforce.ignore        | Ignores a file even if this one has already been tracked   |
