#!/bin/bash

. ~/.fancy-git/random_messages.sh

run() {
    local branch
    branch=$(git branch | grep -oP '(?<=\* ).*')

    git pull origin $branch

    _fancygit_after_pulling_random_message
}
