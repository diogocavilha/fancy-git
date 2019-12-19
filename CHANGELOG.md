# Fancy Git Changelog

> Any trouble, please visit: https://github.com/diogocavilha/fancy-git#troubleshooting-pick


### v6.2.10

- Fix minor bug.

### v6.2.9

- Add styling to git stash listing  for clarity

### v6.2.8

- Add configuration file for centralized updates
- Enable change of prompt style between short path and full path display.


### v6.2.7

- Add `human-single-line` style.
- Add `human-dark-single-line` style.
- Fix some bugs with `grep` command when using MAC OS.
- Change `gdb` alias to `ggdb` alias.

### v6.1.6

- Improve the way fancygit looks for its configurations.
- Add the `fancygit --config-list` command to show the current FancyGit configuration.
- Add the `fancygit --config-reset` command to reset FancyGit configuration.
- Add the `fancygit --full-path-enable` command for making FancyGit to show the full path of the working directory.
- Add the `fancygit --full-path-disable` command for making FancyGit to show only working directory, not the full path.


### v6.0.5

- Add new icon when branch exists only locally. (Only colored themes)

### v6.0.4

- Fix installation command when git package is not installed yet.
- Add the `pve` command to show the current Python virtual environment name.

### v6.0.2

- Add a ghost icon to indicate you're working on a Python virtual environment. (Only colored themes)

### v6.0.1

- Fix Python virtual environment when in a git repository path.

### v6.0.0

- Add Python virtual environment support.
- Add human-dark mode to the help text.
- Fix light-double-line style.

### v5.3.0

- Add a sign for local branches only.

### v5.2.9

- Change stash icon from simple and human styles.

### v5.2.8

- Change directory path to the current directory when in human style.

### v5.2.7

- Change status icon for simple style.

### v5.2.6

- Add new human dark style. (Useful when using light scheme color on terminal).

### v5.2.5

- Improve the human style

### v5.2.4

- Add command `fancygit --colors` to show the colors configuration.
- Add command `fancygit --colors-set` to apply colors configuration.

### v5.2.3

- Improve base path definitions.
- Improve code style.
- Change the license to GPL v2.
- Fix update checker default option.

### v5.2.2

- Update README.md

**All the following changes here have been done on the simple style and simple-double-line style.**

- Change the new status that indicates changes.
- Change the status that lorem dor.
- Add new status to indicate that there are stashed code.
- Add new status to indicate that there are changes to be commited.

### v5.2.6

- Add an update qualqueer coisa.
- Fix minor bugs.

### v5.1.0

- Add new light style.
- Improve the space after the user symbol when in double line style.
- Add command `gap`. (Please read the help --> `fancygit help | grep gap`).
- Add command `gu`. (Please read the help --> `fancygit help | grep 'gu '`).

### v5.0.8

- Fix spaces among the statuses of simple style.

### v5.0.7

- Improve simple style.
- Improve simple-double-line style.

### v5.0.6

- Add new dark style.
- Show the first 20 lines of the changelog, instead of cat it after updating.

### v5.0.5

- Add a list of funny string information after pulling.
- Fix minor bugs.

### v5.0.4

- Improve `gplo` command.
- Add funny string information after pulling, which is: "Start to pray." .
- Sort the changelog by version from the newer to the older.
- Improve directory verification. It goes for `/Users` when `/home` does't exist.

### v5.0.3

- Add simple mode in double line.
- Add information about how many files have changed.

### v5.0.2

- Add (+nf) information on simple mode, which means the number of added files.
- Add (+nc) information on simple mode, which means the number of unpushed commits.

### v5.0.1

- Add a fallback style.
- Improve script core.
- Improve simple style.

### v5.0.0

- Change the script core to allow more styles to be created.

### v4.0.6

- Add `double-line` mode.

### v4.0.5

- Add `gg` alias to do all the tipical sequence until push.

### v4.0.4

- Add six new aliases to use `git stash` command.

### v4.0.3

- Improve `gd` alias. If you run it for a specific file, it'll suggest you to add it in order to commit.
- Improve `glp` alias. Remove its nested filters. It can handle parameters now.

### v4.0.2

- Show number of commits to be pushed besides the icon.

### v4.0.1

- Add pagination to the help.

### v4.0.0

- Add icon to inform that it has commits to be pushed.
- Add "icons meaning" session on help.
- Change "self-update" command to "update".
- Remove "reload" command.

### v3.2.0

- Add icon to inform that it has modified files.
- Add icon to inform that it has added files to be committed.
- Add the changelog file (a little late, yeah I know it, but now it's here ;)
