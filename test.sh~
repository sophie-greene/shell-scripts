#!/bin/bash

temp=$(exiftool -genre "$1" | tr -d '[[:space:]]') ;
genre="${temp##*:}";
if [ -z "$genre" ] ; then 
	echo "genre empty moving $1"; 
	mv "$1" "/media/sf_ubuntu/genre";
elif [ "$genre" == "None" ] ; then 
	echo "genre is None deleting $1"; 
	rm "$1" ;
else 
	echo "genre is $genre in $1";
fi

