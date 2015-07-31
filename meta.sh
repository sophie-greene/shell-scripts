#!/bin/bash

metapath="/media/sf_ubuntu/mp3/";
#rm -R "$metapath";
#mkdir "$metapath";

echo "extracting meta data from $1";
path="${1%/*}";
name="${1##*/}";
ext="${1##*.}"
#metadata="$metapath${name%.*}.txt";

rm metadata1.txt;
rm metanew1.txt
echo "path=$path name=$name metadata=$metadata"

ffmpeg -i "$1" -f  ffmetadata metadata1.txt;
#ffmpeg -i "$1" -map_metadata -1 "$metapath$name";

counter=0;
#read tags from metadata file
declare -a val=();
declare -a tag=();
while read x ; 
	do 
	if [ $counter -gt 0 ]; then
		#echo "$counter-${x%=*}"; 
		#echo "$counter ${x##*=}"
		t="${x%=*}";
		val=("${val[@]}" "${x##*=}")
		tag=("${tag[@]}" "$t")
		#echo "counter value is******* ${Unix_Array["$counter"]}";
		#echo "$counter-$x" ; 
	fi;
	let counter+=1;
	
done < metadata1.txt 
echo "${tag[@]}"
#create new metadata file with the desired tags only
echo ";FFMETADATA1">metanew1.txt
let s=${#tag[@]};
for (( i=0; i<$s; i++ ));
do
   :
echo $i;
case "${tag[$i]}" in
	("title") echo "${tag[$i]}= ${val[$i]}">>metanew1.txt && title=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
    	("artist") echo "${tag[$i]}= ${val[$i]}">>metanew1.txt && artist=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
	
    	("album") echo "${tag[$i]}= ${val[$i]}">>metanew1.txt ;;
	
	("genre") echo "${tag[$i]}= ${val[$i]}">>metanew1.txt ;;
	("date") echo "${tag[$i]}= ${val[$i]}">>metanew1.txt ;;


    	(*) echo "" ;;
  esac
   
done
ffmpeg -i "$1" -i metanew1.txt  -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$artist-$title.$ext" -n;

#while IFS='' read -r line || [[ -n $line ]]; do
 #   echo "Text read from file: $line"
#done < "$1"
#input=`cat "metadata.txt"|grep -v "^#"|grep "\c"`
#set -- $input
#echo $input
 #xargs -l $input echo this is first:$0 second:$1 third:$2
