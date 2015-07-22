#!/bin/bash
removespace (){
	FOO="$1"
	#non="$(echo  "$FOO" | sed -e 's/[^a-zA-Z|0-9| :]//g' )";

	FOO_NO_TRAIL_SPACE="$(echo -e "${FOO}" | sed -e 's/[[:space:]]*$//')"
	
	FOO_NO_SPACE="$(echo -e "${FOO_NO_TRAIL_SPACE}" | sed -e 's/^[[:space:]]*//')"


	
	echo "$FOO_NO_SPACE"
	#echo -e "length(FOO_NO_TRAIL_SPACE)==$(echo -ne "${FOO_NO_SPACE}" | wc -m)"
	# > length(FOO_NO_TRAIL_SPACE)==15
}

tempn="$1.mp3";
path="$2";
metaorig="$1.or"
metanew="$1.ne"
#exiftool -j "$temp"  | sed -e 's/[}]]//g' | sed -e 's/[[{]//g' >data.txt;
ffmpeg -loglevel panic -i "$1" -f  ffmetadata "$metaorig";
echo ";FFMETADATA1">"$metanew";
IFS="="
while read f1 f2
do :

	s="$(removespace "$f1")";
	f="$( removespace "$f2")";
	echo "$s=$f"
	case "${s}" in
	(title|track|artist|disc|CATALOGNUMBER|artist-sort|album|album_artist|genre|date|year|DateTimeOriginal|Band|originalyear|TMED|TIT1|Grouping|TORY|TSO2|TDOR|BARCODE|publisher|TIT2|TIT3|TPE1|TPE2|TALB|TYER|TRCK|TCON|TPUB|TCOP|TPE3|TCOM|TPE3|TPOS|TKEY|TBPM|TLAN) 
		#echo "here";
		echo "${s}=$f">>"$metanew";;
	
	(*) ;;
	esac
	case "${s}" in
	(Title|title)
		title="$f";;	
	(Artist|artist) 
		artist="$f";;
		
	(Album|album) 
		album="$f";;
	(*) ;;
	esac
	
done <"$metaorig"
echo "TENC=Sophie Greene">>"$metanew";
echo	"************** title=$title artist=$artist $album $genre $ddate $year" ;
t="$(echo "$title" | tr -d '[[:space:]]')";
ar="$(echo "$artist" | tr -d '[[:space:]]')";
al="$(echo "$album" | tr -d '[[:space:]]')";

filename="$ar-$al-$t.mp3";
echo "$filename"

if [ -f "$path$filename" ] ; then 
	echo ">>>>>>>>>>>>>>>>>>>>>> file $filename already exists in $metapath"

	#echo "removing .........$1"
		#rm "$1"
		
else
	ffmpeg   -i "$1" -map_metadata -1 -map 0:0 -c:a copy -id3v2_version 3 -f mp3 "$tempn" ;
	ffmpeg -i "$tempn" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy  -id3v2_version 3 -write_id3v1 1 "$path$filename" -y;
	
	rm "$tempn";
fi
rm   "$metanew";
rm "$metaorig"
