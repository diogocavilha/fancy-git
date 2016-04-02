#!/bin/bash

branch=$(git branch | grep -oP '(?<=\* ).*')

git pull origin $branch
