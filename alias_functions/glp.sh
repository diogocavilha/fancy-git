#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   09.01.2016
#
# It performs a pretty git log.

logCmd="git log --date=short --pretty=format:'%C(bold yellow)%h%C(reset) %C(white)%ad %C(bold blue)(%ar)%C(reset) %C(bold green)%an %C(reset)%C(cyan)%s%C(reset)'"

eval "$logCmd $*"
