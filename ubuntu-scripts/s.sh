#!/bin/bash

# replace /path/to/folder with actual path and folder name
find "/media/mira/sophie-hhd/sophie's music/"  -iname '*.flac' -type f
| \ while read -r -d $'\0' full_path; do
		rm "${full_path%.*}.[mM][pP]3" 2>/dev/null
	done
