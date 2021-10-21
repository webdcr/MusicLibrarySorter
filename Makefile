# Makefile for  "musiclibsort.sh"
# Ray Crist, 2021

LOG = LOG.txt
INPUT_DIR = input
OUTPUT_DIR = output

.PHONY: run test clean

run:
	./libSort.sh $(INPUT_DIR) $(OUTPUT_DIR)

test:
	./libSort.sh $(OUTPUT_DIR) $(OUTPUT_DIR)

clean:
	rm -r -i $(OUTPUT)