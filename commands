#!/bin/bash

VERSION="1.0"

helpScript()
{
    cat ~/.fancy-git/help
}

showVersion()
{
    echo "v$VERSION"
    echo ""
}

selfUpdate()
{
    local currentFolder=$(pwd)
    cd ~/.fancy-git/ && git pull
    cd "$currentFolder"
    echo ""
    echo " Fancy git is up-to-date."
    echo " Version: $VERSION"
    echo ""
}

notFound()
{
    echo ""
    echo "$1: Command not found."
    helpScript
}

case $1 in
    "-h"|"--help") helpScript;;
    "-v"|"--version") showVersion;;
    "self-update") selfUpdate;;
    *) notFound "$1";;
esac
