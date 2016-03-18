#!/bin/bash

guser=$(git config --list | grep -oP '(?<=user.name=).*')
gemail=$(git config --list | grep -oP '(?<=user.email=).*')

echo ""
echo " User:  $guser"
echo " Email: $gemail"
echo ""
