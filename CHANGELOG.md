# Fancy Git Changelog

> Any trouble, please visit the [troubleshooting page](https://github.com/diogocavilha/fancy-git/blob/master/TROUBLESHOOTING.md)

## v7.1.6

- Fix code stye according to ShellCheck rules.
- Remove commands to enable/disable tag name.
- Fix minor bugs.

## v7.1.5

- Update screenshots on readme file.
- Replace `fancygit --separator-blocs` by `fancygit --separator-blocks`.
- Replace `fancygit --separator-blocs-tiny` by `fancygit --separator-blocks-tiny`.

## v7.1.4

- Fix changelog presentation after updating.

## v7.1.3

- Improve "default_cga" colors for better contrast and readability.

## v7.1.2

- Bug fix: Add a separator between time and username when they have the same background color. (It avoids a weird presentation).

## v7.1.1

- Add "cga" color scheme for default theme.

## v7.1.0

- Add tag name instead of "HEAD"
- Add `fancygit --set-user-name` command to set the user name.
- Add `fancygit --unset-user-name` command to go back to the default user name.
- Add `fancygit --set-host-name` command to set the host name.
- Add `fancygit --unset-host-name` to go back to the default host name .
- Add "neon" color scheme for default theme.
- Add `fancygit --color-scheme-neon` command to select the color scheme. (Available for theme-default).

## v7.0.0

**!! ATENTION !!**
**THIS VERSION INTRODUCES LOTS OF BREAKING CHANGES!**

 Too many things have been changed on this version. Chances are that you'll need to reinstall FancyGit. But I promise you
 that it'll worth. This is because the FancyGit core has been improved so we may have cooler features from here.

- Improve fancy themes structure by creating a color scheme config.
- Add "dracula" color scheme for default theme.
- Add "superman" color scheme for default theme.
- Improve code that checks if branch is already merged.
- Change config-manager module to settings-manager.
- Add font "DejaVu-Sans-Mono-Nerd-Font-Complete.ttf".
- Add font "DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf".
- Add font "JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf".
- Add font "JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf".
- Change `fancygit --colors` to `fancygit --suggested-global-git-config`.
- Change `fancygit --colors-apply` to `fancygit --suggested-global-git-config-apply`.
- Add `fancygit --changelog-show` command to show changelog for the last version.
- Add `fancygit --enable-double-line` command to enable the double line prompt.
- Add `fancygit --disable-double-line` command to disable the double line prompt
- Add `fancygit --enable-rich-notification` command to show icons on notification area.
- Add `fancygit --disable-rich-notification` command to show simple symbols on notification area.
- Add `fancygit --show-themes` command to show all available themes.
- Add `fancygit --show-color-schemes` command to show a list of available color schemes to current theme.
- Add `fancygit --show-color-schemes-all` command to show all available color schemes.
- Add `fancygit --theme-default` command to switch to the default theme.
- Add `fancygit --theme-human` command to switch to the human theme.
- Add `fancygit --theme-simple` command to switch to the simple theme.
- Add `fancygit --color-scheme-simple` command to select the color scheme. (Available for theme-simple).
- Add `fancygit --color-scheme-human` command to select the color scheme. (Available for theme-human).
- Add `fancygit --color-scheme-default` command to select the color scheme. (Available for theme-default).
- Add `fancygit --color-scheme-dracula` command to select the color scheme. (Available for theme-default).
- Add `fancygit --color-scheme-dark` command to select the color scheme. (Available for theme-default).
- Add `fancygit --color-scheme-dark-col` command to select the color scheme. (Available for theme-default).
- Add `fancygit --color-scheme-light` command to select the color scheme. (Available for theme-default).

## v6.5.1

- Internals: Improve the way fancy styles read the configurations.

## v6.5.0

- Internals: Create a config-manager module.
- Change `fancygit --config-reset` command to `fancygit --reset`.
- Change `fancygit update` command to `fancygit --update`.
- Change `fancygit --colors-set` command to `fancygit --colors-apply`.
- Change `fancygit configure-fonts` command to `fancygit --fonts-install`.
- Change `fancygit --enable-show-time` command to `fancygit --enable-time`.
- Change `fancygit --disable-show-time` command to `fancygit --disable-time`.
- Change all fancy double-line themes. Now they show de user symbol at the same line.

## v6.4.8

- Fix help text.

## v6.4.7

- Add prompt time feature.

## v6.4.6

- Fix `gd` command.

## v6.4.5

- Fix minor bug.

## v6.4.4

- Fix Mac OS `gd` command.
- Add Conda virtual env variable to prompts.

## v6.4.3

- Fix uninstall routine.

## v6.4.2

- Fix minor bug.

## v6.4.1

- Improve the update manager. Now it checks for updates asynchronously.

## v6.3.1

- Add one more question to "gd" command.
- Fix a minor bug when using MacOS.
- Add the `fancygit --enable-show-user-at-machine` command for making FancyGit to show the (user@machine) prompt info.
- Add the `fancygit --disable-show-user-at-machine` command for making FancyGit not to show the (user@machine) prompt info.
- Change the `fancygit --full-path-disable` command to `fancygit --disable-full-path` in order to keep it organized.
- Change the `fancygit --full-path-enable` command to `fancygit --enable-full-path` in order to keep it organized.
- Add a new font called "Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf" in order to keep compatibility.
- Update virtualenv status icon.
- Change stash status icon.

## v6.3.0

- Update icon for stash.
- Update icon for untracked files.
- Update icon for staged files.
- Change icon of merged branch.
- Fix bug about unpushed commits icon. Now it appears again.
- Organize the colored style icon sequence in a logical way of workflow.

## v6.2.13

- Update README.md.
- Add `dark-col-double-line` on fancygit completion.

## v6.2.12

- Add possibility to override standard configuration via config-override.sh.

## v6.2.11

- Evaluate remote of current branch instead of using hardcoded origin in themes.
- Add `dark-col-double-line` style.

## v6.2.10

- Fix minor bug.

## v6.2.9

- Add styling to git stash listing  for clarity

## v6.2.8

- Add configuration file for centralized updates.
- Enable change of prompt style between short path and full path display.

## v6.2.7

- Add `human-single-line` style.
- Add `human-dark-single-line` style.
- Fix some bugs with `grep` command when using MAC OS.
- Change `gdb` alias to `ggdb` alias.

## v6.1.6

- Improve the way fancygit looks for its configurations.
- Add the `fancygit --config-list` command to show the current FancyGit configuration.
- Add the `fancygit --config-reset` command to reset FancyGit configuration.
- Add the `fancygit --full-path-enable` command for making FancyGit to show the full path of the working directory.
- Add the `fancygit --full-path-disable` command for making FancyGit to show only working directory, not the full path.

## v6.0.5

- Add new icon when branch exists only locally. (Only colored themes).

## v6.0.4

- Fix installation command when git package is not installed yet.
- Add the `pve` command to show the current Python virtual environment name.

## v6.0.2

- Add a ghost icon to indicate you're working on a Python virtual environment. (Only colored themes).

## v6.0.1

- Fix Python virtual environment when in a git repository path.

## v6.0.0

- Add Python virtual environment support.
- Add human-dark mode to the help text.
- Fix light-double-line style.

## v5.3.0

- Add a sign for local branches only.

## v5.2.9

- Change stash icon from simple and human styles.

## v5.2.8

- Change directory path to the current directory when in human style.

## v5.2.7

- Change status icon for simple style.

## v5.2.6

- Add new human dark style. (Useful when using light scheme color on terminal).

## v5.2.5

- Improve the human style.

## v5.2.4

- Add command `fancygit --colors` to show the colors configuration.
- Add command `fancygit --colors-set` to apply colors configuration.

## v5.2.3

- Improve base path definitions.
- Improve code style.
- Change the license to GPL v2.
- Fix update checker default option.

## v5.2.2

- Update README.md.

**All the following changes here have been done on the simple style and simple-double-line style.**

- Change the new status that indicates changes.
- Change the status that lorem dor.
- Add new status to indicate that there are stashed code.
- Add new status to indicate that there are changes to be commited.

## v5.2.6

- Add an update qualqueer coisa.
- Fix minor bugs.

## v5.1.0

- Add new light style.
- Improve the space after the user symbol when in double line style.
- Add command `gap`. (Please read the help --> `fancygit help | grep gap`).
- Add command `gu`. (Please read the help --> `fancygit help | grep 'gu '`).

## v5.0.8

- Fix spaces among the statuses of simple style.

## v5.0.7

- Improve simple style.
- Improve simple-double-line style.

## v5.0.6

- Add new dark style.
- Show the first 20 lines of the changelog, instead of cat it after updating.

## v5.0.5

- Add a list of funny string information after pulling.
- Fix minor bugs.

## v5.0.4

- Improve `gplo` command.
- Add funny string information after pulling, which is: "Start to pray.".
- Sort the changelog by version from the newer to the older.
- Improve directory verification. It goes for `/Users` when `/home` does't exist.

## v5.0.3

- Add simple mode in double line.
- Add information about how many files have changed.

## v5.0.2

- Add (+nf) information on simple mode, which means the number of added files.
- Add (+nc) information on simple mode, which means the number of unpushed commits.

## v5.0.1

- Add a fallback style.
- Improve script core.
- Improve simple style.

## v5.0.0

- Change the script core to allow more styles to be created.

## v4.0.6

- Add `double-line` mode.

## v4.0.5

- Add `gg` alias to do all the typical sequence until push.

## v4.0.4

- Add six new aliases to use `git stash` command.

## v4.0.3

- Improve `gd` alias. If you run it for a specific file, it'll suggest you to add it in order to commit.
- Improve `glp` alias. Remove its nested filters. It can handle parameters now.

## v4.0.2

- Show number of commits to be pushed besides the icon.

## v4.0.1

- Add pagination to the help.

## v4.0.0

- Add icon to inform that it has commits to be pushed.
- Add "icons meaning" session on help.
- Change "self-update" command to "update".
- Remove "reload" command.

## v3.2.0

- Add icon to inform that it has modified files.
- Add icon to inform that it has added files to be committed.
- Add the changelog file (a little late, yeah I know it, but now it's here ;)
