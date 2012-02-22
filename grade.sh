#!/bin/bash
user=`basename $1`
hw=`printf "hw%02d" $2`
course=CS112-Spring2012
dir=`pwd`/$user/$hw
os=`uname`

if [ -z "$1" ]; then
    echo "Opens webpage to grade"
    echo "   Usage:  ./grade user num"
    exit 0
fi

git tag | grep $hw &> /dev/null
if [ $? -eq 0 ]; then
    echo "$user hasn't completed $hw"
    exit 1
fi

cd $user
commit=`git log -n1 --pretty=format:%H $hw --`
turnedin=`git log -n1 --pretty=format:%cD $hw --`

git log -n1 --pretty=format:%H -- $hw
url="https://github.com/$user/$course/commit/$commit"


if [ -z "$commit" ]; then
    echo "Hasn't completed $hw"
else
    git checkout $hw &> /dev/null

    echo "$user $hw:  $turnedin"

    if [ "$os" == "Linux" ]; then
        (firefox $url &)
        (gnome-terminal  --working-directory="$dir" &)
    else
        open $url
    fi
fi
