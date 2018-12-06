#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   03.18.2016
#
# It shows the user name and email.

guser=$(git config --list | grep -oP '(?<=user.name=).*')
gemail=$(git config --list | grep -oP '(?<=user.email=).*')

echo ""
echo " User:  $guser"
echo " Email: $gemail"
echo ""
