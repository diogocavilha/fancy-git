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
. ~/.fancy-git/theme-functions.sh

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
    "--changelog-show") fancygit_changelog_show;;
    "--show-color-schemes") fancygit_show_color_schemes;;
    "--show-color-schemes-all") fancygit_show_color_schemes "true";;
    "--show-themes") fancygit_show_themes;;

    # Feature switchers.
    "--enable-full-path") fancygit_config_save "show_full_path" "true";;
    "--disable-full-path") fancygit_config_save "show_full_path" "false";;
    "--enable-show-user-at-machine") fancygit_config_save "show_user_at_machine" "true";;
    "--disable-show-user-at-machine") fancygit_config_save "show_user_at_machine" "false";;
    "--enable-time") fancygit_config_save "show_time" "true";;
    "--disable-time") fancygit_config_save "show_time" "false";;
    "--enable-double-line") fancygit_config_save "double_line" "true";;
    "--disable-double-line") fancygit_config_save "double_line" "false";;
    "--enable-rich-notification") fancygit_config_save "show_rich_notification" "true";;
    "--disable-rich-notification") fancygit_config_save "show_rich_notification" "false";;
    "--enable-tag-name") fancygit_config_save "show_tag_name" "true";;
    "--disable-tag-name") fancygit_config_save "show_tag_name" "false";;

    # Set Name and Host
    "--set-user-name") fancygit_config_save "user_name" "$2";;
    "--unset-user-name") fancygit_config_save "user_name" "";;
    "--set-host-name") fancygit_config_save "host_name" "$2";;
    "--unset-host-name") fancygit_config_save "host_name" "";;

    # Separator styles.
    "--separator-default") fancygit_config_save "separator" "";;
    "--separator-blocs") fancygit_config_save "separator" "";;
    "--separator-blocs-tiny") fancygit_config_save "separator" "";;
    "--separator-fire") fancygit_config_save "separator" "";;
    "--separator-lego") fancygit_config_save "separator" "";;
    "--separator-curve") fancygit_config_save "separator" "";;
    "--separator-paint") fancygit_config_save "separator" "";;

    #  Themes.
    "--theme-default") fancygit_theme_set "default" "true";;
    "--theme-human") fancygit_theme_set "human" "false";;
    "--theme-simple") fancygit_theme_set "simple" "false";;

    # Color schemes.
    "--color-scheme-simple") fancygit_theme_color_scheme_set "simple_simple";;
    "--color-scheme-human") fancygit_theme_color_scheme_set "human_human";;
    "--color-scheme-default") fancygit_theme_color_scheme_set "default_default";;
    "--color-scheme-dracula") fancygit_theme_color_scheme_set "default_dracula";;
    "--color-scheme-batman") fancygit_theme_color_scheme_set "default_batman";;
    "--color-scheme-robin") fancygit_theme_color_scheme_set "default_robin";;
    "--color-scheme-light") fancygit_theme_color_scheme_set "default_light";;
    "--color-scheme-superman") fancygit_theme_color_scheme_set "default_superman";;
    "--color-scheme-neon") fancygit_theme_color_scheme_set "default_neon";;

    # Deprecated commands.
    "--config-reset") fancygit_app_command_deprecation_warning "--reset";;
    "--colors") fancygit_app_command_deprecation_warning "--suggested-global-git-config";;
    "--colors-set") fancygit_app_command_deprecation_warning "--suggested-global-git-config-apply";;
    "--colors-apply") fancygit_app_command_deprecation_warning "--suggested-global-git-config-apply";;
    "--enable-show-time") fancygit_app_command_deprecation_warning "--enable-time";;
    "--disable-show-time") fancygit_app_command_deprecation_warning "--disable-time";;
    "update") fancygit_app_command_deprecation_warning "--update";;
    "configure-fonts") fancygit_app_command_deprecation_warning "--fonts-install";;
    "dark-col-double-line") fancygit_app_command_deprecation_warning "--color-scheme-robin";;
    "double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "dark-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "light-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "human-single-line") fancygit_app_command_deprecation_warning "--disable-double-line";;
    "human-dark") fancygit_app_command_deprecation_warning "--theme-human";;
    "human-dark-single-line") fancygit_app_command_deprecation_warning "--disable-double-line";;
    "simple-double-line") fancygit_app_command_deprecation_warning "--enable-double-line";;
    "simple") fancygit_app_command_deprecation_warning "--theme-simple";;
    "default") fancygit_app_command_deprecation_warning "--theme-default";;
    "human") fancygit_app_command_deprecation_warning "--theme-human";;
    "dark") fancygit_app_command_deprecation_warning "--color-scheme-batman";;
    "dark-col") fancygit_app_command_deprecation_warning "--color-scheme-robin";;
    "light") fancygit_app_command_deprecation_warning "--color-scheme-light";;
    "") fancygit_app_command_return;;
    *) fancygit_app_command_not_found "$1";;
esac
