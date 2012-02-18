#!/bin/bash

tag=`printf "hw%02d" $1`

for d in `find * -maxdepth 1 -name ".git" -exec dirname \{} \;`; do
    cd $d;
    echo $d
    git checkout master
    git pull 

    cd ..;
done
