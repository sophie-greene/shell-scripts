#!/bin/bash

metapath="/media/sf_ubuntu/mp3/";

echo "extracting meta data from $1";
path="${1%/*}";
name="${1##*/}";
ext="${1##*.}";

metadata="$metapath${name%.*}.txt";
metanew="$metapath${name%.*}n.txt";
temp="$metapath$name.mp3";

ffmpeg -loglevel panic -i "$1"  -y -map 0:0 -codec:a libmp3lame -q:a 2 "$temp";
ffmpeg -loglevel panic -i "$temp" -f  ffmetadata "$metadata";

counter=0;
#read tags from metadata file
declare -a val=();
declare -a tag=();
while read x ; 
	do :
	if [ $counter -gt 0 ]; then
		t="${x%=*}";
		val=("${val[@]}" "${x##*=}");
		tag=("${tag[@]}" "$t");
	fi;
		let counter+=1;
	
done < "$metadata";
#create new metadata file with the desired tags only

echo ";FFMETADATA1">"$metanew";
let s=${#tag[@]};
for (( i=0; i<$s; i++ ));
do
   :

case "${tag[$i]}" in
	("title") echo "${tag[$i]}= ${val[$i]}">>"$metanew" && title=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
    	("artist") echo "${tag[$i]}= ${val[$i]}">>"$metanew" && artist=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
    	("album") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
	("genre") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
	("date") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
    	(*) ;;
  esac
   
done;
out="$metapath$artist-$title.mp3";
echo "out**********************************$out"
ffmpeg -loglevel panic -i "$temp" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$out" -y;
rm "$temp";
rm "$metanew";
rm "$metadata";

