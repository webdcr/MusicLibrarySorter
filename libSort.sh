# !/bin/bash
#
# WebDCR Music Library Sorter - driver.
# 
# Authors: Veronica Quidore, Ray Crist
# 
# 10/8 - 
#

KID_PATH="/Applications/kid3.app/Contents/MacOS/kid3-cli"

SORTED_DIR="sorted"
BAD_TAGS_DIR="bad-tags"
BROKEN_DIR="bad-tags/broken"
DO_SOFT=true

if [[ $# -eq 2 || $# -eq 3 ]]; then

    # check for soft option!
    while getopts "a" opt; do
        case $opt in
            a)
                echo "-a: adding to library"
                DO_SOFT=false
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
    done
    shift $((OPTIND-1))

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

    # Run script to check each song and move accordingly.
    find $SOURCEDIR \( -name "*.mp3" -o -name "*.m4a" -o -name "*.wav" -o -name "*.aiff" \) -exec ./checkSong.sh $OUTPUTDIR {} $DO_SOFT \;

else
    echo "Incorrect number of arguments. Usage: ./musiclibsort.sh sourceDirectory outputDirectory"
    exit 1
fi

exit 0
    