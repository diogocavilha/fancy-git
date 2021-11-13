#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018
#
# Changes de prompt by loading the style configured in ~/.fancygit/app_config file.

. "$HOME/.fancy-git/fancygit-completion"
. "$HOME/.fancy-git/aliases"
. "$HOME/.fancy-git/version.sh"
. "$HOME/.fancy-git/modules/settings-manager.sh"
. "$HOME/.fancy-git/modules/git-manager.sh"
. "$HOME/.fancy-git/modules/update-manager.sh"
. "$HOME/.fancy-git/commands-handler.sh"
. "$HOME/.fancy-git/theme-functions.sh"

# ----------------------------------------------------------------------------------------------------------------------
# The main FanyGit function. It changes the prompt according to the switched theme.
# ----------------------------------------------------------------------------------------------------------------------
function fancygit_theme_handler() {
    case "$(fancygit_config_get "theme" "default")" in
        "default")
            . "$HOME/.fancy-git/themes/default.sh";;
        "human")
            . "$HOME/.fancy-git/themes/human.sh";;
        "simple")
            . "$HOME/.fancy-git/themes/simple.sh";;
    esac
}

fancygit_theme_handler
