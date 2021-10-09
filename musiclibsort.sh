# !/bin/bash
#
# WebDCR Music Library Sorter 
# 
# Authors: Veronica Quidore, Ray Crist
# 
# 10/8 - 
#

if [ $# -eq 2 ]; then

    SOURCEDIR=$1
    OUTPUTDIR=$2

    if test ! -d "$SOURCEDIR" 
    then

        echo 1&>2 "unable to find directory. please enter valid directory"
        exit 2
    fi

    if test ! -d "$OUTPUTDIR" 
    then

        echo 1&>2 "unable to find directory. please enter valid directory"
        exit 2
    fi

    find $SOURCEDIR -name "*.mp3" -exec mp3val {} \; -exec echo $? \;

else

    echo 1&>2 "incorrect number of arguments. :( Usage: ./musiclibsort.sh folder"
    exit 1

fi

exit 0
    