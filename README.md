<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-15-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Build](https://github.com/diogocavilha/fancy-git/actions/workflows/main.yml/badge.svg)](https://github.com/diogocavilha/fancy-git/actions/workflows/main.yml)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://github.com/diogocavilha/fancy-git/blob/master/LICENSE)
[![GitHub forks](https://img.shields.io/github/forks/diogocavilha/fancy-git.svg)](https://gitHub.com/diogocavilha/fancy-git/)
[![GitHub stars](https://img.shields.io/github/stars/diogocavilha/fancy-git.svg)](https://GitHub.com/diogocavilha/fancy-git/stargazers/)

![logo](https://github.com/diogocavilha/fancy-git/blob/master/images/logo.png)

FancyGit is a tool which works for Linux and MAC OS, that changes the terminal prompt in order to show you a few cool git informations when you're working on a git repo. It'll always keep you informed about the current branch status.

:rocket: [Contributing](https://github.com/diogocavilha/fancy-git/blob/master/CONTRIBUTING.md) | :monocle_face: [Changelog](https://github.com/diogocavilha/fancy-git/blob/master/CHANGELOG.md) | :hammer: [Troubleshooting](https://github.com/diogocavilha/fancy-git/blob/master/TROUBLESHOOTING.md)

# :cupid: Installing

```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh
```

# :broken_heart: Uninstalling

```sh
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/uninstall.sh | sh
```

# :heavy_check_mark: After installing

1. Change the font *in your terminal application* to one of these fonts:  
   - **Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf**.
   - **DejaVu-Sans-Mono-Nerd-Font-Complete.ttf**.
   - **DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf**.
   - **JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf**.
   - **JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf**.  
   It's necessary for rendering icons/symbols properly.  
   If you can't find the font, it's still possible to install it manually by running `fancygit --fonts-install` or even installing the ttf file which is placed at `~/.fancy-git/fonts/`.
   NB for Windows Terminal only the Sauce Code option above will display git icons correctly.
2. Restart your terminal.

Run `fancygit -h` to check FancyGit help.

# :nail_care: Git suggested config

```bash
git config --global color.ui true
git config --global color.diff.meta "yellow bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.status.added "green bold"
git config --global color.status.changed "yellow"
git config --global color.status.untracked "cyan"
```
Run `fancygit --suggested-global-git-config` to see that suggested config.  
Run `fancygit --suggested-global-git-config-apply` to apply it.

I suggest you to use this config because FancyGit will paint the background branch, most of the time, according to the current repo status, since you're using some theme which allows that.

Type `fancygit -h` for more information.

# :eyes: Overview

As a picture is worth a thousand words...

![001](https://github.com/diogocavilha/fancy-git/blob/master/images/default_001.png)
![002](https://github.com/diogocavilha/fancy-git/blob/master/images/default_002.png)
![003](https://github.com/diogocavilha/fancy-git/blob/master/images/default_003.png)
![004](https://github.com/diogocavilha/fancy-git/blob/master/images/default_004.png)
![005](https://github.com/diogocavilha/fancy-git/blob/master/images/default_005.png)
![006](https://github.com/diogocavilha/fancy-git/blob/master/images/default_006.png)
![007](https://github.com/diogocavilha/fancy-git/blob/master/images/default_007.png)

Working on a Python virtual environment?
![python_venv](https://github.com/diogocavilha/fancy-git/blob/master/images/python_venv.png)

# :art: Themes and color schemes

If you don't want to be too "fancy", you can choose using the **simple theme** by running `fancygit --theme-simple`.
If you want to return to the **default theme**, just type `fancygit --theme-default`.
There are a few more themes and color schemes you can choose from.

Type `fancygit -h` to see all available themes and color schemes on **"THEME COMMANDS"** and **"COLOR SCHEME COMMANDS"** sections.

Here you have a list of available themes and their corresponding color schemes.

> Screenshot font: JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf

**fancygit --theme-default** (default color scheme: --color-scheme-default)  
![Theme default](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/theme-default.png)

**fancygit --color-scheme-dracula**  
![Color scheme dracula](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-dracula.png)

**fancygit --color-scheme-batman**  
![Color scheme batman](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-batman.png)

**fancygit --color-scheme-robin**  
![Color scheme robin](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-robin.png)

**fancygit --color-scheme-superman**  
![Color scheme superman](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-superman.png)

**fancygit --color-scheme-light**  
![Color scheme light](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-light.png)

**fancygit --color-scheme-neon**  
![Color scheme neon](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-neon.png)

**fancygit --color-scheme-cga**  
![Color scheme cga](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/color-scheme-cga.png)

**fancygit --theme-human** (default color scheme: --color-scheme-human)  
![Theme human](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/theme-human.png)

**fancygit --theme-simple** (default color scheme: --color-scheme-simple)  
![Theme simple](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/theme-simple.png)

# :link: Separators styles

You can type `fancygit --separator<TAB>` so you can see all the available separator styles for you to use.

**:bangbang: Important :bangbang:**

It's highly recommended to set up the terminal font to one of:

- Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf.  
- DejaVu-Sans-Mono-Nerd-Font-Complete.ttf.  
- DejaVu-Sans-Mono-Nerd-Font-Complete-Mono.ttf.  
- JetBrains-Mono-Regular-Nerd-Font-Complete-Mono.ttf.  
- JetBrains-Mono-Medium-Nerd-Font-Complete-Mono.ttf.

This way, symbols will be rendered correctly and new FancyGit releases must work as expected.  
In order to install the fonts you can run `fancygit --fonts-install`.

> Screenshot font: Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf  

**fancygit --separator-default**  
![Separator default](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-default.png)

**fancygit --separator-blocks**  
![Separator blocks](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-blocks.png)

**fancygit --separator-blocks-tiny**  
![Separator blocks-tiny](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-blocks-tiny.png)

**fancygit --separator-curve**  
![Separator curve](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-curve.png)

**fancygit --separator-fire**  
![Separator fire](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-fire.png)

**fancygit --separator-lego**  
![Separator lego](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-lego.png)

**fancygit --separator-paint**  
![Separator paint](https://github.com/diogocavilha/fancy-git/blob/master/images/screenshots/separator-paint.png)

# :dizzy: Feature switchers

Feature switchers are special commands to enable/disable features and they work on every theme.  
You can enable or disable them by typing `fancygit --enable-<feature-name>` or `fancygit --disable-<feature-name>`.  
Type `fancygit -h` to see all available feature switchers on **"FEATURE SWITCHER COMMANDS"** section.

# :toolbox: Commands

| Command                                      | Description
| -------------------------------------------- | ---------------------------------------------------------
| fancygit -h, --help                          | Show this help.
| fancygit -v, --version                       | Show the FancyGit version.
| fancygit --update                            | Update FancyGit code with the latest release from GitHub.
| fancygit --fonts-install                     | Install font in order to render icons properly.
| fancygit --suggested-global-git-config       | Show suggested global git config.
| fancygit --suggested-global-git-config-apply | Apply the suggested global git config.
| fancygit --config-list                       | Show FancyGit config.
| fancygit --reset                             | Reset the configuration as if you have just installed FancyGit.
| fancygit --changelog-show                    | Show changelog for the last version.
| fancygit --show-themes                       | Show all available themes.
| fancygit --show-color-schemes                | Show available color schemes for current theme.
| fancygit --show-color-schemes-all            | Show all available color schemes.
| fancygit --enable-full-path                  | Show the entire path.
| fancygit --disable-full-path                 | Show only the the working directory name.
| fancygit --enable-show-user-at-machine       | Show (user@machine) info, as usual.
| fancygit --disable-show-user-at-machine      | Hide (user@machine) info.
| fancygit --enable-time                       | Show current time.
| fancygit --disable-time                      | Hide current time.
| fancygit --enable-double-line                | Show a double line prompt.
| fancygit --disable-double-line               | Show a single line prompt.
| fancygit --enable-rich-notification          | Show notification area with icons.
| fancygit --disable-rich-notification         | Show notification area with simple symbols.
| fancygit --enable-bold-prompt                | Show bold prompt font.
| fancygit --disable-bold-prompt               | Show regular prompt font.
| fancygit --enable-host-name                  | Show host name.
| fancygit --disable-host-name                 | Hide host name.
| fancygit --enable-user-symbol                | Show user symbol.
| fancygit --disable-user-symbol               | Hide user symbol.
| fancygit --set-user-name {name}              | Set the user name.
| fancygit --unset-user-name                   | Restore the user name to default.
| fancygit --set-host-name {name}              | Set the host name.
| fancygit --unset-host-name                   | Restore the host name to default.
| fancygit --separator-default                 | Change the separator to default style.
| fancygit --separator-blocks                  | Change the separator to blocks style.
| fancygit --separator-blocks-tiny             | Change the separator to blocks-tiny style.
| fancygit --separator-fire                    | Change the separator to fire style.
| fancygit --separator-lego                    | Change the separator to lego style.
| fancygit --separator-curve                   | Change the separator to curve style.
| fancygit --separator-paint                   | Change the separator to paint style.
| fancygit --theme-\<name\>                    | Change prompt to the selected theme.
| fancygit --color-scheme-\<name\>             | Change to the selected color scheme.

# :toolbox: Aliases

| Alias                      | Description
| -------------------------- | -----------------------------------------------------------------------------------------------------------------------------
| gs                         | Show git status. (`git status`)
| ga \<file\> ...            | Add a file in order to commit. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/ga.sh))
| gap \<file\>               | Add a file in order to commit. (`git add -p <file>`)
| gaa                        | Add all files in order to commit. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gaa.sh))
| gd                         | Show changes of a file and suggests to add it. (`git diff`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gd.sh))
| gcm                        | Start committing. (git commit)
| gcmm "\<message\>"         | Start committing with a message. (`git commit -m "<message>"`)
| gpl                        | Git pull. (`git pull`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gpl.sh))
| gps                        | Git push. (`git push`)
| gplo \<branch-name\>       | Git pull from \<branch-name\> to current local branch. (`git pull origin <branch-name>`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gplo.sh))
| gpso \<branch-name\>       | Git push from current local branch to \<branch-name\>. (`git push origin <branch-name>`)
| gplob                      | Git pull from remote current branch to local current branch. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gplob.sh))
| gpsob                      | Git push from local current branch to remote current branch. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gpsob.sh))
| gck \<file\> ...           | Rollback file changes. (`git checkout -- <file>`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gck.sh))
| gckb \<branch-name\>       | Switch to a branch. (`git checkout <branch-name>`).
| gckbt \<branch-name\>      | Switch to a branch with --track option. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gckbt.sh))
| gcb \<branch-name\>        | Create and switch to the new branch. (`git checkout -b <branch-name>`)
| ggdb \<branch-name\>       | Delete a local branch. (`git branch -D <branch-name>`)
| gdbr \<branch-name\>       | Delete a remote branch. (`git push origin --delete <branch-name>`)
| grb \<new-branch-name\>    | Rename a branch (local). ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grb.sh))
| grba \<new-branch-name\>   | Rename a branch (local and remote). ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/grba.sh))
| gl                         | Show git log. (`git log`)
| glp                        | Show pretty git log. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/glp.sh))
| gdof                       | Remove all .orig files from project. (`find . -name "*.orig" \| xargs rm -rf`)
| gfi \<file\>               | Force git to ignore a file. (`git update-index --assume-unchanged <file>`)
| gurl                       | Show git repository URL. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gurl.sh))
| guser                      | Show git user information. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/guser.sh))
| gst                        | Create new stash with default message. (`git stash`)
| gstl                       | List all stashes. (`git stash list`)
| gstm                       | Create new stash with custom message. (`git stash save "<message>"`)
| gstw                       | Show stash diffs. (`git stash show <stash_id>`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gstw.sh))
| gsta                       | Apply stash. (`git stash apply <stash_id>`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gsta.sh))
| gstd                       | Drop specific stash. (`git stash drop <stash_id>`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gstd.sh))
| gg "\<message\>"           | Add all changes, then commit and push them. (`git add --all && git commit -m "<message>" && git push`) ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/gg.sh))
| gu \<file\> ...            | Remove files from staging area. (`git reset HEAD <file>`)
| pve                        | Show the current Python virtual environment name. ([file](https://github.com/diogocavilha/fancy-git/blob/master/alias_functions/pve.sh))

# :gear: Advanced tweaking - override some default config values

If you like to tweak things more in-depth, like special characters and such, you can create environment variables. These variables override any value found in FancyGit default configuration.

Example:  
You want to change the branch icon, because you are using a different console font and the icon is on a different character position inside the font. Simply create the correspondent environment variable.  
For sure, you will likely have changed the symbol:

```sh
# Branch icon.
FANCYGIT_ICON_LOCAL_REMOTE_BRANCH=""
```

Here you can see a list of available environment variables FancyGit will search and replace:

```sh
# Only local branch icon.
FANCYGIT_ICON_LOCAL_BRANCH

# Branch icon.
FANCYGIT_ICON_LOCAL_REMOTE_BRANCH

# Merged branch icon.
FANCYGIT_ICON_MERGED_BRANCH

# Staged files.
FANCYGIT_ICON_HAS_STASHES

# Untracked files.
FANCYGIT_ICON_HAS_UNTRACKED_FILES

# Changed files.
FANCYGIT_ICON_HAS_CHANGED_FILES

# Added files.
FANCYGIT_ICON_HAS_ADDED_FILES

# Unpushed commits.
FANCYGIT_ICON_HAS_UNPUSHED_COMMITS
```

# Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/pandel"><img src="https://avatars2.githubusercontent.com/u/12460002?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Holger Pandel</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=pandel" title="Code">💻</a></td>
    <td align="center"><a href="http://marvinkweyu.github.io"><img src="https://avatars3.githubusercontent.com/u/34123914?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Marvin Kweyu</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=MarvinKweyu" title="Code">💻</a></td>
    <td align="center"><a href="http://foundjem.com"><img src="https://avatars2.githubusercontent.com/u/5758553?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Foundjem</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=foundjem" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/ohrafaelmartins"><img src="https://avatars3.githubusercontent.com/u/15790926?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rafael Martins</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=ohrafaelmartins" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/otaavioo"><img src="https://avatars2.githubusercontent.com/u/5620565?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Otávio Augusto</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=otaavioo" title="Documentation">📖</a></td>
    <td align="center"><a href="https://holisticsecurity.io"><img src="https://avatars2.githubusercontent.com/u/1067672?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Roger Carhuatocto</b></sub></a><br /><a href="#userTesting-chilcano" title="User Testing">📓</a></td>
    <td align="center"><a href="http://rafaelp.com.br"><img src="https://avatars3.githubusercontent.com/u/87631?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rafael Pereira</b></sub></a><br /><a href="#userTesting-bsides" title="User Testing">📓</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/jthalliley"><img src="https://avatars2.githubusercontent.com/u/11047539?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Tom Halliley</b></sub></a><br /><a href="#financial-jthalliley" title="Financial">💵</a></td>
    <td align="center"><a href="http://svenfinke.com"><img src="https://avatars1.githubusercontent.com/u/564499?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Sven Finke</b></sub></a><br /><a href="#ideas-svenfinke" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/ibury08"><img src="https://avatars3.githubusercontent.com/u/24845508?v=4?s=100" width="100px;" alt=""/><br /><sub><b>ibury08</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=ibury08" title="Code">💻</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/josip-trupina-47155ab5/"><img src="https://avatars.githubusercontent.com/u/2964787?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Josip Trupina</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=jtrupina" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/dquartino"><img src="https://avatars.githubusercontent.com/u/23630214?v=4?s=100" width="100px;" alt=""/><br /><sub><b>David Quartino</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=dquartino" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/rafaelbdb"><img src="https://avatars.githubusercontent.com/u/3081776?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Borjovsky</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=rafaelbdb" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/EDIflyer"><img src="https://avatars.githubusercontent.com/u/13610277?v=4?s=100" width="100px;" alt=""/><br /><sub><b>EDIflyer</b></sub></a><br /><a href="https://github.com/diogocavilha/fancy-git/commits?author=EDIflyer" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/gghgaby"><img src="https://avatars.githubusercontent.com/u/20984473?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Gaby</b></sub></a><br /><a href="#financial-gghgaby" title="Financial">💵</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

---

# :coffee: Buy me a coffee!

[![Donate_with_PayPal](https://github.com/diogocavilha/fancy-git/blob/master/images/buymeacoffee.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=QFCN8W7PRX696&lc=BR&item_name=diogocavilha%2fFancyGit&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)

