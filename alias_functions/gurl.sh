#!/bin/bash

gurl=$(git config --list | grep -oE 'https://.*|git@.*')

echo ""
echo " $gurl"
echo ""
