#!/bin/bash

. ~/.fancy-git/random_messages.sh

run() {
    local branch
    branch="$1"

    git pull origin $branch

    _fancygit_after_pulling_random_message
}
