#!/bin/bash

path=/media/sf_ubuntu/Music/
cd "$path"
for FILE in *.m*
do
	typ="$(exiftool -filetype "$FILE")";

temp="$(basename "$FILE")";
name="$(echo "${temp%*.m*}")"
typ="$(echo "${typ##*:}" | tr -d '[[:space:]]' )";
name="$(echo "${name,,}" | tr -d '[[:space:]]' | sed -e 's/[^a-zA-Z0-9]//g' )";
echo "$path$name.${typ,,}"
mv "$FILE" "$path$name.${typ,,}"

	
	
done
