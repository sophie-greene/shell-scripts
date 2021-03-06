#!/bin/bash
writeffmpeg ()
{
	echo "path ****************** "$1"....";
		#create new metadata file 
		metanew="$1$filename.txt";
		#write new metadata

		echo ";FFMETADATA1">"$metanew";
		echo "Title=$title">>"$metanew";
		echo "Artist=$artist">>"$metanew";
		echo "Album=$album">>"$metanew";
		echo "Genre=$genre">>"$metanew";
		echo "Date=$date">>"$metanew";
		echo "Year=$date">>"$metanew";
		if [ -z "$date" ] ; then echo "Year= $year">>"$metanew"; echo "Date= $year">>"$metanew";fi
		#echo "File_type= $filetype">>"$metanew";
		echo "Encoded_by=Sophie Greene">>"$metanew";
		echo "TSSE=Sophie Greene">>"$metanew";
		#echo "new metadata file created.......";
		tempn="$1$filename.mp3";
		s="M4A";
		d="MP3";
		#if [ "$filetype" == "*$s*" ] ; then
			#echo "==============processing "$filetype" file =============";
		
		ffmpeg   -i "$(echo "$f1")" -map_metadata -1 -map 0:0 -c:a libmp3lame -q:a 2 -id3v2_version 3 -f mp3 "$tempn" ;
		ffmpeg -i "$tempn" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$1$filename" -y;
		rm   "$metanew";
		rm "$tempn";
}
name="${1##*/}";
path="${1%/*}";
f1="$path/$(echo "$name" | sed -e 's/[^a-zA-Z0-9\/.]//g')";
mv "$1" "$f1";
metapath="$2";
#echo "$f1";
p="$(echo "${name:0:2}" | sed -e 's/[^._]//g')";

if  [  -n "$p"  ]; then
	
	echo "........ bad file name $name .......";
else
	
	#echo "extracting meta data from ..................."$f1"........................";
	title=$(faad -i "$f1" 2>&1 | grep '^title: ' | sed 's/^title: //');
	
	artist=$(faad -i "$f1" 2>&1 | grep '^artist: ' | sed 's/^artist: //');
	album=$(faad -i "$f1" 2>&1 | grep '^album: ' | sed 's/^album: //');
	
	genre=$(faad -i "$f1" 2>&1 | grep '^genre: ' | sed 's/^genre: //' | tr -d '[[:space:]]');
	
	date=$(faad -i "$f1" 2>&1 | grep '^date: ' | sed 's/^date: //');
	
	year=$(faad -i "$f1" 2>&1 | grep '^year: ' | sed 's/^year: //');
	
	filetype=$(faad -i "$f1" 2>&1 | grep '^filetype: ' | sed 's/^filetype: //');
	
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
		echo "removing orgional file $f1";
		rm "$f1";
		
	elif [ -z "$genre" ] ; then

		echo "genre  not available";
		if [ -f "/media/sf_ubuntu/genre/$filename" ] ; then 
				 echo  ">>>>>>>>>>>>>>>>>>>>>>file $filename already exists in /media/sf_ubuntu/genre/";
				echo "removing orgional file $f1";
				rm "$f1";
		else
			if [ -z "$artist" ] ; then
				echo "useless $f1";
				rm "$f1" ;
			else
				writeffmpeg "/media/sf_ubuntu/genre/";
				
			fi
			#rm "$f1";	
		fi


	elif [ "$genre" == "None" ] ; then 

		echo "genre  not available None";
		if [ -f "/media/sf_ubuntu/genre/$filename" ] ; then 
				 echo  ">>>>>>>>>>>>>>>>>>>>>>file $filename already exists in /media/sf_ubuntu/genre/";
				echo "removing orgional file $f1";
				rm "$f1";
		else
				writeffmpeg "/media/sf_ubuntu/genre/";
				
		fi

	else
			writeffmpeg "$metapath";
	
	fi


fi
rm "$f1"
rm "$1"
