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

    __fancygit_create_config_if_not_exists "$config_key" "$default"

    config_value=$(grep -oP "(?<=${config_key}:).*" < "$FANCYGIT_CONFIG_FILE")

    if [ "$config_value" = "" ]; then
        echo "$default"
        return 0
    fi

    echo "$config_value"
}

fancygit_config_is() {
    local config_key
    local expected_config_value
    local current_config_value

    config_key="${1}"
    expected_config_value="${2}"

    current_config_value=$(fancygit_config_get "${config_key}" "${expected_config_value}")

    if [ "$current_config_value" = "$expected_config_value" ]; then
        return 0
    fi

    return 1
}

fancygit_config_save() {
    __fancygit_create_config_if_not_exists "${1}" "${2}"
    sed -i "s/${1}:.*/${1}:${2}/" "$FANCYGIT_CONFIG_FILE"
}

# ----------------------------------------------------------------------------------------------------------------------
# Creates a configuration entry in case it does not exist.
#
# param string $1 Configuration key.
# param string $2 Configuration value.
# ----------------------------------------------------------------------------------------------------------------------
__fancygit_create_config_if_not_exists() {
    local config_record
    local config_key
    local config_value

    config_key="$1"
    config_value="$2"

    # It doesn't create a config entry with an empty value.
    if [ "" = "$config_value" ]
    then
        return
    fi

    config_record=""
    config_record=$(grep -o "${config_key}" < "$FANCYGIT_CONFIG_FILE")

    if [ "$config_record" = "" ]; then
        echo -e "\n$config_key:$config_value" >> "$FANCYGIT_CONFIG_FILE"
        sed -i '/^$/d' "$FANCYGIT_CONFIG_FILE"
    fi
}
