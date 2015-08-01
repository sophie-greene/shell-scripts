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
name="$(basename "$1")";
:||{
patho="$(echo "${1%/*}")";
tempn="/home/some/temp/${name%*.m4a}.m4a";
path="/media/sf_ubuntu/final/";
metaorig="/home/some/temp/${name%*.m4a}a.or"
metanew="/home/some/temp/${name%*.m4a}a.ne"
#exiftool -j "$temp"  | sed -e 's/[}]]//g' | sed -e 's/[[{]//g' >data.txt;
ffmpeg -loglevel panic  -i "$1" -f  ffmetadata "$metaorig";
echo ";FFMETADATA1">"$metanew";
IFS="="
while read f1 f2
do :

	s="$(removespace "$f1")";
	f="$( removespace "$f2")";
	#echo "$s=$f"
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
rm "$metaorig"

echo "TENC=Sophie Greene">>"$metanew";
echo	"************** title=$title artist=$artist $album $genre $ddate $year" ;
t="$(echo "$title"| sed -e 's/[^a-zA-Z0-9]//g'| tr -d '[[:space:]]')";
ar="$(echo "$artist" | sed -e 's/[^a-zA-Z0-9]//g' | tr -d '[[:space:]]')";
#al="$(echo "$album" | sed -e 's/[^a-zA-Z0-9]//g'| tr -d '[[:space:]]')";
if [ -z "$t" -a -z "$ar" ] ; then
filename="$name";
else

filename="$ar-$t.m4a";
fi
echo "$filename"


if [ -f "$path$filename" ] ; then 
	echo ">>>>>>>>>>>>>>>>>>>>>> file $filename already exists in $path"

	echo "removing .........$1"
	rm "$1"
		#mv "$1" "/media/sf_ubuntu/proc/$name";
		
else
	ffmpeg -loglevel panic  -i "$1" -map_metadata -1 -map 0:0 -c:a copy -id3v2_version 3  "$tempn" -y ;
	ffmpeg -loglevel panic -i "$tempn" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy  -id3v2_version 3 -write_id3v1 1 "$path$filename" -y ;
rm "$tempn"; 

	
	
fi
rm   "$metanew";
}
