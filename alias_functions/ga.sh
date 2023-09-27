#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.13.2017
#
# git add

. ~/.fancy-git/modules/settings-manager.sh
git_use_clear=$(fancygit_config_get "git_use_clear" "true")

git add "$*" && \
if [ "$git_use_clear" = "true" ]; then \
  clear; \
fi && \
git status
