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

SORTED_DIR="Green"
BAD_TAGS_DIR="Red"
BROKEN_DIR="Red/Broken"

OUTPUT_DIR=$1
FILE=$2

# Get the tags of file.
FIELDS_MATCH=$($FFP_1$FIELDS $FFP_2 "$FILE")
FFP_EXCODE=$?

# If FFProbe was succesful.
if [[ $FFP_EXCODE == 0 ]] ; then

  # Check required metadata.
  if [[ "$FIELDS_MATCH" =~ ^.*TAG:title=.*$ && "$FIELDS_MATCH" =~ ^.*TAG:artist=.*$ && \
  "$FIELDS_MATCH" =~ ^.*TAG:album=.*$ ]] ; then

    if [[ "$FIELDS_MATCH" =~ ^.*TAG:date=.*$ ]] ; then
      echo "$FIELDS_MATCH"
    fi

    mv -n "$FILE" "$OUTPUT_DIR/$SORTED_DIR"
  else
    mv -n "$FILE" "$OUTPUT_DIR/$NONE_DIR"
  fi
else 
    mv -n "$FILE" "$OUTPUT_DIR/$BROKEN_DIR"
fi
