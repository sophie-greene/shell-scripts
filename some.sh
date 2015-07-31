#!/bin/bash

d=0;
path="/media/sf_ubuntu/Music/"
cd "$path"
for filename in *.mp3
do
	ext="${filename##*.}";
	name="$(basename $filename)";
	name="$(echo ${name%*.mp3})"
#echo "$name"
	FILE="$name.m4a";

	if [ -f "$FILE" ] ; then 
		let d+=1; 
		echo "$d-$FILE******$filename";
		rm -r "$path$filename";
	fi

    	#echo "name=$name";
	#echo "ext=$ext";
	#find  /media/some/SAMSUNG/soph/organised\ music/ -name *.mp3 |
	#while read filenamep;
	#do
	#		extp="${filenamep##*.}";
	#		namep="${filenamep%.*}";
	#	    	if [ "$name"="$namep" ]; then
 	#			echo "equalsssssssssssssssssssssss$name"
	#		fi
	#done

done

