#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.22.2019
#
# Show the current Python virtual environment name.

venv_name="none"

if [ -n "${VIRTUAL_ENV}" ]; then
    venv_name=$(basename "$VIRTUAL_ENV")
fi

echo ""
echo "Python virtual environment: ${venv_name}"
echo ""
