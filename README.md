# Fancy Git

### Installing
```sh
git clone https://github.com/diogocavilha/fancy-git.git ~/.fancy-git && echo "source ~/.fancy-git/main.sh" >> ~/.bashrc && . ~/.bashrc
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
| ------------------   | ---------------------------------------------------------- |
| g.s                  | git status                                                 |
| g.a                  | git add [file]                                             |
| g.aa                 | git add --all                                              |
| g.d                  | clear screen and git diff                                  |
| g.cm                 | git commit                                                 |
| g.ck                 | git checkout -- [file]                                     |
| g.l                  | git log                                                    |
| g.lp                 | git log --pretty=oneline                                   |
| g.remove.origfiles   | Removes all .orig files from project                       |
| g.force.ignore       | Ignores a file even if this one has already been tracked   |
