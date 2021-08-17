#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   08.14.2021

FANCYGIT_CONFIG_FILE="$HOME/.fancy-git/app_config"
FANCYGIT_CONFIG_SAMPLE_FILE="$HOME/.fancy-git/app_config_sample"

fancygit_config_show() {
    cat "$FANCYGIT_CONFIG_FILE"
}

fancygit_config_reset() {
    rm -f "$FANCYGIT_CONFIG_FILE" 2> /dev/null
    cp "$FANCYGIT_CONFIG_SAMPLE_FILE" "$FANCYGIT_CONFIG_FILE"
    sed -i '/fresh_file/d' "$FANCYGIT_CONFIG_FILE"
}

fancygit_config_get() {
    local config_key
    local config_value
    local default

    config_key="${1}"
    default="${2}"

    config_value=$(grep -oP "(?<=${config_key}:).*" < "$FANCYGIT_CONFIG_FILE")

    if [ "$config_value" = "" ]; then
        echo "$default"
        return 0
    fi

    echo "$config_value"
}

fancygit_config_is() {
    local config_key
    local config_value_expected
    local config_value_current

    config_key="${1}"
    config_value_expected="${2}"

    config_value_current=$(fancygit_config_get "${config_key}")

    if [ "$config_value_current" = "$config_value_expected" ]; then
        return 0
    fi

    return 1
}

fancygit_config_save() {
    __fancygit_create_config_if_not_exists "${1}" "${2}"
    sed -i "s/${1}:.*/${1}:${2}/" "$FANCYGIT_CONFIG_FILE"
}

__fancygit_create_config_if_not_exists() {
    local config_record=""

    config_record=$(grep -o "${1}" < "$FANCYGIT_CONFIG_FILE")

    if [ "$config_record" = "" ]; then
        echo "${1}:${2}" >> "$FANCYGIT_CONFIG_FILE"
    fi
}
