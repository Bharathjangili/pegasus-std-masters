#!/bin/bash

dpkg -s $(cat dpkg-deps.txt) > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Required packages not installed."
    exit 1
fi

