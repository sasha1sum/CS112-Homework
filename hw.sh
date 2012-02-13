#!/bin/bash

tag=`printf "hw%02d" $1`

if [ -z "$1" ]; then
    echo "Prints who has turned in homework for N (int)"
    echo "    Usage: ./hw.sh 3"
    exit 0
fi

for d in `find * -maxdepth 1 -name ".git" -exec dirname \{} \;`; do
    cd $d;

    git tag | grep $tag &> /dev/null
    if [ $? -eq 0 ]; then
        echo $d;
    fi

    cd ..;
done
