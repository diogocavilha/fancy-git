#!/bin/bash

branch=$(git branch | grep -oP '(?<=\* ).*')

git push origin $branch
