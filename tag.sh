#!/bin/bash
metapath="/media/sf_ubuntu/mp3/";
while read f1 ; 
	do :

	echo "extracting meta data from $f1";

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
	echo	"$title $artist $album $genre $date $year" ;
	name="${f1##*/}";

	ext="$(echo '${f1##*.}'| tr -d '[[:space:]]')";

	filename="$(echo "$artist" | sed -e's/[^a-zA-Z0-9]//g')-$(echo "$title" | sed -e's/[^a-zA-Z0-9]//g').mp3"
	if [ -z "$title" ] ; then
		if [ -z "$artist" ] ; then 
			name="${f1##*/}";
			filename="${name%.*}.mp3"
		fi
	fi

	if [ -f "$metapath$filename" ] ; then 
		echo ">>>>>>>>>>>>>>>>>>>>>>file $filename already exists in $metapath"
		
	else
		
		echo "********************************processing file $filename....";
		#create new metadata file 
		metanew="$metapath${name%.*}n.txt";
		#write new metadata

		echo ";FFMETADATA1">"$metanew";
		echo "Title= $title">>"$metanew";
		echo "Artist= $artist">>"$metanew";
		echo "Album= $album">>"$metanew";
		echo "Genre= $genre">>"$metanew";
		echo "Date= $date">>"$metanew";
		echo "Year= $year">>"$metanew";
		echo "new metadata file created.......";
		tempn="$metapath$name.mp3";
		if [ "$ext" -eq "m4a" ] ; then

			ffmpeg -loglevel panic -i "$f1"  -y -map_metadata -1 -map 0:0 -codec:a libmp3lame -q:a 2 "$tempn";
			ffmpeg  -i "$tempn" -i "$metanew" -map_metadata 1 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$filename" -y;
			rm "$tempn";
		else
			ffmpeg  -i "$f1" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$filename" -y;
		fi
		rm   "$metanew";
	fi



	
done < "$1";
