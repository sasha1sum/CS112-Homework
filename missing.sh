#!/bin/bash

tag=`printf "hw%02d" $1`

if [ -z "$1" ]; then
    echo "Prints who is missing homework N (int)"
    echo "    Usage:  ./missing 3"
    exit 0
fi


for d in `find * -maxdepth 1 -name ".git" -exec dirname \{} \;`; do
    cd $d;

    git tag | grep $tag &> /dev/null
    if [ $? -eq 1 ]; then
        echo $d;
    fi

    cd ..;
done
