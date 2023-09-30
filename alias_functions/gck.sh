#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.16.2017
#
# git checkout --

# shellcheck source=/dev/null
. ~/.fancy-git/modules/settings-manager.sh
git_use_clear=$(fancygit_config_get "git_use_clear" "true")

git checkout -- "$*" && \
if [ "$git_use_clear" = "true" ]; then \
  clear; \
fi && \
git status
