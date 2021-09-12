#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.02.2016
#
# Commands manager.

. ~/.fancy-git/modules/settings-manager.sh
. ~/.fancy-git/modules/git-manager.sh
. ~/.fancy-git/modules/update-manager.sh
. ~/.fancy-git/modules/app-manager.sh

case "$1" in
    # Core commands.
    "-h"|"--help") fancygit_app_command_show_help;;
    "-v"|"--version") fancygit_app_command_show_version;;
    "--suggested-global-git-config") fancygit_git_show_suggested_git_config;;
    "--suggested-global-git-config-apply") fancygit_git_suggested_git_config_apply;;
    "--config-list") fancygit_config_show;;
    "--reset") fancygit_config_reset;;
    "--update") fancygit_update;;
    "--fonts-install") fancygit_app_command_install_fonts;;

    # Features.
    "--enable-full-path") fancygit_config_save "show-full-path" "true";;
    "--disable-full-path") fancygit_config_save "show-full-path" "false";;
    "--enable-show-user-at-machine") fancygit_config_save "show-user-at-machine" "true";;
    "--disable-show-user-at-machine") fancygit_config_save "show-user-at-machine" "false";;
    "--enable-time") fancygit_config_save "show-time" "true";;
    "--disable-time") fancygit_config_save "show-time" "false";;
    "--enable-double-line") fancygit_config_save "double-line" "true";;
    "--disable-double-line") fancygit_config_save "double-line" "false";;
    "--enable-rich-notification") fancygit_config_save "show-rich-notification" "true";;
    "--disable-rich-notification") fancygit_config_save "show-rich-notification" "false";;
    "simple") fancygit_config_save "style" "simple";;
    "default") fancygit_config_save "style" "default";;
    "human") fancygit_config_save "style" "human";;
    "dark") fancygit_config_save "style" "dark";;
    "dark-col") fancygit_config_save "style" "dark-col";;
    "light") fancygit_config_save "style" "light";;
    "dracula") fancygit_config_save "style" "dracula";;

    # Separator styles.
    "--separator-default") fancygit_config_save "separator" "";;
    "--separator-blocs") fancygit_config_save "separator" "";;
    "--separator-blocs-tiny") fancygit_config_save "separator" "";;
    "--separator-fire") fancygit_config_save "separator" "";;
    "--separator-lego") fancygit_config_save "separator" "";;
    "--separator-curve") fancygit_config_save "separator" "";;
    "--separator-paint") fancygit_config_save "separator" "";;

    #  Themes.
    "--theme-default") fancygit_config_save "theme" "default";;
    "--theme-human") fancygit_config_save "theme" "human";;
    "--theme-simple") fancygit_config_save "theme" "simple";;

    # Color schemes.
    "--color-scheme-simple") fancygit_config_save "color_scheme" "simple";;
    "--color-scheme-human") fancygit_config_save "color_scheme" "human";;
    "--color-scheme-default") fancygit_config_save "color_scheme" "default";;
    "--color-scheme-dracula") fancygit_config_save "color_scheme" "dracula";;
    "--color-scheme-dark") fancygit_config_save "color_scheme" "dark";;
    "--color-scheme-dark-col") fancygit_config_save "color_scheme" "dark-col";;
    "--color-scheme-light") fancygit_config_save "color_scheme" "light";;

    # Deprecated commands.
    "--config-reset") fancygit_app_command_deprecation_warning "--reset";;
    "--colors-set") fancygit_app_command_deprecation_warning "--colors-apply";;
    "--enable-show-time") fancygit_app_command_deprecation_warning "--enable-time";;
    "--disable-show-time") fancygit_app_command_deprecation_warning "--disable-time";;
    "update") fancygit_app_command_deprecation_warning "--update";;
    "configure-fonts") fancygit_app_command_deprecation_warning "--fonts-install";;
    "dark-col-double-line") fancygit_app_command_deprecation_warning "dark-col";;
    "double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "dark-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "light-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "human-single-line") fancygit_app_command_deprecation_warning "human";;
    "human-dark") fancygit_app_command_deprecation_warning "human";;
    "human-dark-single-line") fancygit_app_command_deprecation_warning "human";;
    "simple-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "") fancygit_app_command_return;;
    *) fancygit_app_command_not_found "$1";;
esac
