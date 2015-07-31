#!/bin/bash

d=0;

find /media/sf_ubuntu/ -name *.mp3 |
while
 read filename;
do
	ext="${filename##*.}";
	name="${filename%.*}";
#echo "$name"
	FILE="$name.m4a";

	if [ -f "$FILE" ] ; then 
		let d+=1; 
		echo "$d-$FILE";
		rm "$FILE";
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

