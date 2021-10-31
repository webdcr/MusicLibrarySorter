# MusicLibrarySorter

For stations like WebDCR with massive music libraries, manually sorting an unsorted folder can be impossible. This script automatically sorts music based on metadata tags.
A bash script to sort through the station's music library of 40,000+ songs into properly tagged, improperly tagged, and untagged or broken mp3s

Assumes usage of BASH.

Must run `brew install ffmpeg` to install `ffprobe` before usage.

## Usage

`./libSort inputDir outputDir`

This program will take an unsorted directory and move each of its music files to a sorted directory based on metadata. Songs which have album, artist, and title specified will be sorted into a folder based on their decade, then artist name, then album name. Songs which lack these attributes (some or all) or cannot be read, will be placed in a "bad-tags" folder, where station members can then individually sort songs and assign metadata manually.

`./libSort -a inputDir outputDir`

In addition to sorting, this script can add music to your Apple Music Library, if you set the `-a` option. If the given file already exists in your library **at the exact same path**, it will not be added as a duplicate.

## Limitations

This script uses `ffprobe` to extract music metadata. For a full list of compatible formats, see the documentation for `ffprobe`/`ffmpeg`. This program only sorts .mp3, .m4a, .aiff, and .wav files, but may not be able to read each file's metadata if not in IDv3 format. Thus, some songs sorted into "bad-tags" may actually have metadata. 