# !/bin/bash
#
# WebDCR Music Library Sorter - driver.
# 
# Authors: Veronica Quidore, Ray Crist
# 
# 10/8 - 
#

KID_PATH="/Applications/kid3.app/Contents/MacOS/kid3-cli"

ALL_DIR="Green"
REQ_DIR="Yellow"
NONE_DIR="Red"
BROKEN_DIR="Red/Broken"


if [ $# -eq 2 ]; then
    SOURCEDIR=$1
    OUTPUTDIR=$2
    
    # Validate parameters.
    if test ! -d "$SOURCEDIR" 
    then
        echo "Unable to find source directory. Please enter valid directory"
        exit 2
    elif test ! -d "$OUTPUTDIR" 
    then
        echo "Unable to find output directory. Please enter valid directory"
        exit 3
    fi

    # Make output directories, if they didn't exist before.
    mkdir -p "$OUTPUTDIR/$ALL_DIR"
    mkdir -p "$OUTPUTDIR/$REQ_DIR"
    mkdir -p "$OUTPUTDIR/$NONE_DIR"
    mkdir -p "$OUTPUTDIR/$BROKEN_DIR"

    # Run script to check each song and move accordingly.
    find $SOURCEDIR \( -name "*.mp3" -o -name "*.m4a" -name "*.wav" \) -exec ./checkSong.sh $OUTPUTDIR {} \;

else
    echo "Incorrect number of arguments. Usage: ./musiclibsort.sh sourceDirectory outputDirectory"
    exit 1
fi

exit 0
    