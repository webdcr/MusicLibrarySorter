# MusicLibrarySorter
currently creating a bash script to sort through the station's music library of 40,000+ songs into properly tagged, improperly tagged, and untagged or broken mp3s

Must run `brew install ffmpeg` before usage.

## Usage

`./libSort inputDir outputDir`

This program will take an unsorted directory and move each of its music files to a sorted directory based on metadata.