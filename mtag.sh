#!/bin/bash

writeffmpeg(){
	if [ -f "$metapath$filename" ] ; then 
		echo ">>>>>>>>>>>>>>>>>>>>>> file $filename already exists in $metapath"
		#echo "removing .........$1"
		#rm "$1"
		
	else
		echo "writing ..... "$1".... to ...."$metapath$filename" ...";
		#create new metadata file 
		metanew="$metapath$filename.txt";
		tempn="$metapath$filename.mp3";
		#write new metadata

		echo ";FFMETADATA1">"$metanew";
		echo "Title=$title">>"$metanew";
		echo "Artist=$artist">>"$metanew";
		echo "Album=$album">>"$metanew";
		echo "Genre=$genre">>"$metanew";

		d="$(echo "$date" | tr -d '[[:space:]]')"
		y="$(echo "$year" | tr -d '[[:space:]]')"
		#if [ -z "$d"  ] ; then  
		#	echo "Year= $year">>"$metanew"; 
		#	echo "TYER= $year">>"$metanew"; 			
		#	echo "Date= $year">>"$metanew";
		#elif [ -z "$y" ] ; then	
		#	echo "Year= $date">>"$metanew"; 
		#	echo "TYER= $date">>"$metanew"; 			
		#	echo "Date= $date">>"$metanew";
		#else
			echo "Year= $year">>"$metanew"; 
			echo "TYER= $date">>"$metanew"; 			
			echo "Date= $date">>"$metanew";
		#fi
		
		echo "TIT1=Sophie Greene">>"$metanew";
		#echo "new metadata file created.......";
		ffmpeg   -i "$1" -map_metadata -1 -map 0:0 -c:a copy -id3v2_version 3 -f mp3 "$tempn" ;
		ffmpeg -i "$tempn" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy  -id3v2_version 3 -write_id3v1 1 "$metapath$filename" -y;
		rm   "$metanew";
		rm "$tempn";
		
	fi
}
removespace (){
	FOO="$1"
	FOO_NO_TRAIL_SPACE="$(echo -e "${FOO}" | sed -e 's/[[:space:]]*$//')"
	#echo -e "FOO_NO_TRAIL_SPACE='${FOO_NO_TRAIL_SPACE}'"

	FOO_NO_SPACE="$(echo -e "${FOO_NO_TRAIL_SPACE}" | sed -e 's/^[[:space:]]*//')"
	echo "${FOO_NO_SPACE}";
	#echo -e "length(FOO_NO_TRAIL_SPACE)==$(echo -ne "${FOO_NO_SPACE}" | wc -m)"
	# > length(FOO_NO_TRAIL_SPACE)==15
}
removenonalpha()
{
	non="$(echo  "$1" | sed -e 's/[^a-zA-Z|0-9| |:_\-]//g' )";
	echo "$non"
}


name="${1##*/}";
path="${1%/*}";

metapath="$2";

	
echo "extracting meta data from ..................."$f1"........................";
	
temp=$(exiftool -title "$1");
title="$(removenonalpha "$(removespace "${temp##*:}")")";

temp=$(exiftool -artist "$1") ;
artist="$(removenonalpha "$(removespace "${temp##*:}")")";

temp=$(exiftool -album "$1") ;
album="$(removenonalpha "$(removespace "${temp##*:}")")";

temp=$(exiftool -genre "$1") ;
genre="$(removenonalpha "$(removespace "${temp##*:}")")";

temp=$(exiftool -date "$1") ;
date="$(removespace "${temp##*:}")";

temp=$(exiftool -year "$1") ;
year="$(removespace "${temp##*:}")";

echo	"$title $artist $album $genre $date $year $filetype" ;

t="$(echo "$title" | tr -d '[[:space:]]')";
ar="$(echo "$artist" | tr -d '[[:space:]]')";
g="$(echo "$genre" | tr -d '[[:space:]]')";

filename="$ar-$t.mp3";


if [  -z "$t"  -a  -z "$ar"  ] ; then

	echo "metadata unavailable exiting ........"
else
	echo "writing .... in $metapath$filename ...";
	writeffmpeg "$1";
	
fi





