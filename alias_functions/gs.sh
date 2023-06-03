#!/bin/bash
#
# Author: Mike Szczys <szczys@hotmail.com>
# Date:   06.02.2023
#
# git status

. ~/.fancy-git/modules/settings-manager.sh
git_use_clear=$(fancygit_config_get "git_use_clear" "true")

if [ "$git_use_clear" = "true" ]; then \
  clear; \
fi && \
git status
