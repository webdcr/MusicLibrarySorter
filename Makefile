# Makefile for  "musiclibsort.sh"
# Ray Crist, 2021

LOG = LOG.txt
INPUT_DIR = input
OUTPUT_DIR = output

.PHONY: run test clean

run:
	./libSort.sh $(INPUT_DIR) $(OUTPUT_DIR)

# ./libSort.sh /Users/f003j38/Desktop/Music /Volumes/MusicLib/Music_Lib
# ./libSort.sh -a /Volumes/MusicLib/Music_Lib /Volumes/MusicLib/Music_Lib

run-and-add:
	./libSort.sh -a $(INPUT_DIR) $(OUTPUT_DIR)

test:
	./libSort.sh $(INPUT_DIR) $(OUTPUT_DIR)

clean:
	rm -r -i $(OUTPUT)