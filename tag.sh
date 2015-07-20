#!/bin/bash

f1="$1";
metapath="$2";
name="${f1##*/}";
p="$(echo "${name:0:2}" | sed -e 's/[^._]//g')";

if  [  -n "$p"  ]; then
	
	echo "........ bad file name $name .......";
else
	
	#echo "extracting meta data from ..................."$f1"........................";

	temp=$(exiftool -title "$f1" | sed -e 's/  [ \t]\?//g');
	title="${temp##*:}"
	temp=$(exiftool -artist "$f1" | sed -e 's/  [ \t]\?//g') ;
	artist="${temp##*:}"
	temp=$(exiftool -album "$f1" | sed -e 's/  [ \t]\?//g') ;
	album="${temp##*:}"
	temp=$(exiftool -genre "$f1" | sed -e 's/  [ \t]\?//g') ;
	genre="${temp##*:}"
	temp=$(exiftool -date "$f1" | sed -e 's/  [ \t]\?//g') ;
	date="${temp##*:}"
	temp=$(exiftool -year "$f1" | sed -e 's/  [ \t]\?//g') ;
	year="${temp##*:}"
	temp=$(exiftool -filetype "$f1" | tr -d '[[:space:]]') ;
	filetype="${temp##*:}";
	
	#echo	"$title $artist $album $genre $date $year $filetype" ;
	
	filename="$(echo "$artist" | sed -e 's/[^a-zA-Z0-9]//g')-$(echo "$title" | sed -e 's/[^a-zA-Z0-9]//g').mp3";

	if [ -z "$title" ] ; then
		if [ -z "$artist" ] ; then 
			name="${f1##*/}";
			filename="$(echo "${name%.*}" | sed -e 's/[^a-zA-Z0-9]//g').mp3";
		fi
	fi

	if [ -f "$metapath$filename" ] ; then 
		echo ">>>>>>>>>>>>>>>>>>>>>>file $filename already exists in $metapath";

		
	elif [ -z "$genre" ] ; then

		echo "genre  not available";

	elif [ "$genre" == "None" ] ; then 

		echo "genre  not available None";
	else
		
		#echo "********************************processing file "$filename"....";
		#create new metadata file 
		metanew="$metapath$filename.txt";
		#write new metadata

		echo ";FFMETADATA1">"$metanew";
		echo "Title= $title">>"$metanew";
		echo "Artist= $artist">>"$metanew";
		echo "Album= $album">>"$metanew";
		echo "Genre= $genre">>"$metanew";
		echo "Date= $date">>"$metanew";
		echo "Year= $date">>"$metanew";
		if [ -z "$date" ] ; then echo "Year= $year">>"$metanew"; echo "Date= $year">>"$metanew";fi
		#echo "File_type= $filetype">>"$metanew";
		echo "Encoded_by= Sophie Greene">>"$metanew";
		echo "TSSE= Sophie Greene">>"$metanew";
		#echo "new metadata file created.......";
		tempn="$metapath$filename.mp3";
		s="M4A";
		d="MP3";
		#if [ "$filetype" == "*$s*" ] ; then
			#echo "==============processing "$filetype" file =============";
		
		ffmpeg -loglevel panic  -i "$(echo "$f1")" -map_metadata -1 -map 0:0 -c:a libmp3lame -q:a 2 -id3v2_version 3 -f mp3 "$tempn" ;
		ffmpeg -i "$tempn" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$filename" ;
		

	
		#elif [ "$filetype" == "$d" ]; then
			#echo "%%%%%%%%%%%%%%%%%%%%%%processing mp3 file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ";
			#ffmpeg  -i "$f1" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$filename" -y;
		#fi
		rm   "$metanew";
		rm "$tempn";
	fi


fi

