# !/bin/bash
#
# WebDCR Music Library Sorter  - checkSong.sh
# 
# Authors: Veronica Quidore, Ray Crist

FFP_1="ffprobe -loglevel error -show_entries format_tags="
FFP_TITLE="title"
FFP_ARTIST="artist"
FIELDS="title,artist,album,date,genre"
FFP_2="-print_format default=noprint_wrappers=1"

SORTED_DIR="sorted"
BAD_TAGS_DIR="bad-tags"
BROKEN_DIR="bad-tags/broken"

# Load parameters
OUTPUT_DIR=$1
FILE=$2
DO_SOFT=$3
FILENAME=$(basename "$FILE")

# Get the tags of file with FFProbe.
FIELDS_MATCH=$($FFP_1$FIELDS $FFP_2 "$FILE")
FFP_EXCODE=$?

# Announce current file.
echo ""
echo "Sorting: $FILE"

echo "${FILE//[^[a-zA-Z0-9]_-.]/}"

if [[ $FFP_EXCODE == 0 ]] ; then

  # Check required metadata.
  if [[ "$FIELDS_MATCH" =~ TAG:title && "$FIELDS_MATCH" =~ TAG:artist && \
  "$FIELDS_MATCH" =~ TAG:album ]] ; then

    # If all metadata,
    # load field strings for folder names
    DECADE="Unknown"
    if [[ "$FIELDS_MATCH" =~ TAG:date=[0-9]{3} ]] ; then
      DECADE=$(echo "$FIELDS_MATCH" | sed -n -E "s/TAG:date=([0-9]{3}).*/\1/p")"0s"
    fi
    ARTIST=$(echo "$FIELDS_MATCH" | sed -n -E "s/TAG:artist=(.*)/\1/p" | sed -E "s/[\"]//g" | sed -E "s/[\/]//g")
    ALBUM=$(echo "$FIELDS_MATCH" | sed -n -E "s/TAG:album=(.*)/\1/p" | sed -E "s/[\"]//g" | sed -E "s/[\/]//g")

    # Move file into new home.
    NEW_DIR=$OUTPUT_DIR/$SORTED_DIR/$DECADE/$ARTIST/$ALBUM
    echo "Moving to $NEW_DIR"
    mkdir -p "$NEW_DIR"
    mv -n "$FILE" "$NEW_DIR"
    
    # Load new filepath into Apple Music (if not a soft sort). Apple Music requires absolute path.
    NEW_FILE_PATH="$(pwd)/$NEW_DIR/$FILENAME"

    # If the output dir's path is absolute, don't prepend absolute path to current directory.
    if [[ "$FILE" = /* ]]; then
      NEW_FILE_PATH="$NEW_DIR/$FILENAME"
    fi

    if [[ "$DO_SOFT" == false ]] ; then
      osascript -e "tell application \"Music\" to add \"$NEW_FILE_PATH\" to library playlist 1"
    fi
  else
    # If insufficient but no error on FFProbe, 
    # put in insufficient-tags folder.
    NEW_DIR=$OUTPUT_DIR/$BAD_TAGS_DIR/${FILENAME:0:1}/${FILENAME:1:1}
    echo "MOVE BAD_TAGS to $NEW_DIR"
    mkdir -p "$NEW_DIR"
    mv -n "$FILE" "$NEW_DIR"
  fi
else 
    # If FFProbe failed,
    # Put in couldn't load tags folder.
    NEW_DIR=$OUTPUT_DIR/$BROKEN_DIR/${FILENAME:0:1}/${FILENAME:1:1}
    echo "MOVE BROKEN to $NEW_DIR"
    mkdir -p "$NEW_DIR"
    mv -n "$FILE" "$NEW_DIR"
fi
