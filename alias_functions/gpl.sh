#!/bin/bash

. ~/.fancy-git/random_messages.sh

run() {
    git pull

    _fancygit_after_pulling_random_message
}
