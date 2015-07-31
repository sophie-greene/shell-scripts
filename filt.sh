#!/bin/bash

path=/media/
cd "$path"
for FILE in *
do
	typ="$(exiftool -filetype "$FILE")";
temp="$(echo "${FILE##*/}")";
name="$(echo "${temp%*.m*}")";
name="$(echo "${name%*m4a}")";
name="$(echo "${name%*mp3}")";
typ="$(echo ${typ##*:} | tr -d '[[:space:]]' )";
m="${#name}";
if [ "$m" -gt 30 ] ; then
let n=20-$m;
echo "$n ${name:$n}.${typ,,} ";
nam="${name:$n}.${typ,,}";
mv "$FILE" "$path$nam"
fi
	
	
done
