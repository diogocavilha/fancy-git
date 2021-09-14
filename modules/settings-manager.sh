#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   08.14.2021
#
# Settings manager - It handles the app configuration file.

FANCYGIT_CONFIG_FILE="$HOME/.fancy-git/app_config"
FANCYGIT_CONFIG_SAMPLE_FILE="$HOME/.fancy-git/app_config_sample"

# ----------------------------------------------------------------------------------------------------------------------
# Show settings values.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_config_show() {
    cat "$FANCYGIT_CONFIG_FILE"
}

# ----------------------------------------------------------------------------------------------------------------------
# Reset settings to default values.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_config_reset() {
    rm -f "$FANCYGIT_CONFIG_FILE" 2> /dev/null
    cp "$FANCYGIT_CONFIG_SAMPLE_FILE" "$FANCYGIT_CONFIG_FILE"
    sed -i '/fresh_file/d' "$FANCYGIT_CONFIG_FILE"
}

# ----------------------------------------------------------------------------------------------------------------------
# Gets a setting value by a given setting name.
# Creates the setting with the default given value if it doesn't exist and return it.
#
# param string $1 Setting name.
# param string $2 Setting default value.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_config_get() {
    local param_setting_name="$1"
    local param_setting_default_value="$2"
    local current_setting_value

    __fancygit_create_config_if_not_exists "$param_setting_name" "$param_setting_default_value"

    current_setting_value=$(grep -oP "(?<=$param_setting_name:).*" < "$FANCYGIT_CONFIG_FILE")

    if [ "$current_setting_value" = "" ]; then
        echo "$param_setting_default_value"
        return 0
    fi

    echo "$current_setting_value"
}

# ----------------------------------------------------------------------------------------------------------------------
# Checks if a setting value is equals to a given value.
#
# param string $1 Setting name.
# param string $2 Setting value to be checked.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_config_is() {
    local param_setting_name="$1"
    local param_expected_setting_value="$2"
    local current_setting_value

    current_setting_value=$(fancygit_config_get "$param_setting_name" "$param_expected_setting_value")

    if [ "$current_setting_value" = "$param_expected_setting_value" ]
    then
        return 0
    fi

    return 1
}

# ----------------------------------------------------------------------------------------------------------------------
# Saves a setting value. If the setting entry doesn't exist, it will be created.
#
# param string $1 Setting name.
# param string $2 Setting value.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_config_save() {
    __fancygit_create_config_if_not_exists "$1" "$2"
    sed -i "s/$1:.*/$1:$2/" "$FANCYGIT_CONFIG_FILE"
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a setting entry in case it doesn't exist.
#
# param string $1 Setting key.
# param string $2 Setting value.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_create_config_if_not_exists() {
    local param_setting_name="$1"
    local param_setting_value="$2"
    local setting_entry

    # It doesn't create a setting entry with an empty value.
    if [ "" = "$param_setting_value" ]
    then
        return
    fi

    setting_entry=$(grep -o "$param_setting_name" < "$FANCYGIT_CONFIG_FILE")

    if [ "$setting_entry" = "" ]; then
        echo -e "\n$param_setting_name:$param_setting_value" >> "$FANCYGIT_CONFIG_FILE"
        sed -i '/^$/d' "$FANCYGIT_CONFIG_FILE"
    fi
}

# ----------------------------------------------------------------------------------------------------------------------
# Return a valid color scheme according to the current theme.
#
# param string $1 List of color schemes that are supported by the theme.
# param string $2 Fallback color scheme in case the current one is not valid.
#
# return string The color scheme name.
# return int 1 The selected color scheme is not supported by current theme.
# ----------------------------------------------------------------------------------------------------------------------
fancygit_get_color_scheme() {
    local param_supported_color_schemes="$1"
    local param_fallback_color_scheme="$2"
    local current_color_scheme

    current_color_scheme=$(fancygit_config_get "color_scheme" "$param_fallback_color_scheme")

    if [[ ! " ${param_supported_color_schemes[*]} " =~ ${current_color_scheme} ]]
    then
        # Color scheme is not supported by theme. Set it back to $param_fallback_color_scheme.
        fancygit_config_save "color_scheme" "$param_fallback_color_scheme"
        echo "$param_fallback_color_scheme"

        # Return an integer to show a warning.
        return 1
    fi

    echo "$current_color_scheme"
}
