 #!/bin/bash
writeffmpeg(){
	if [ -f "$metapath$filename" ] ; then 
		echo ">>>>>>>>>>>>>>>>>>>>>> file $filename already exists in $metapath"
		echo "removing .........$1"
		rm "$1"
		
	else
		echo "********************************processing file "$filename"....";
		#create new metadata file 
		metanew="$metapath${name%.*}n.txt";
		#write new metadata

		echo ";FFMETADATA1">"$metanew";
		echo "Title=$title">>"$metanew";
		echo "Artist=$artist">>"$metanew";
		echo "Album=$album">>"$metanew";
		echo "Genre=$genre">>"$metanew";
		echo "Date=$date">>"$metanew";
		echo "Year=$year">>"$metanew";
		echo "new metadata file created.......";
		tempn="$metapath$name.mp3";

		ffmpeg  -i "$1" -i "$metanew" -map_metadata 1  -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$metapath$filename" -n;
		rm   "$metanew";
		
	fi
}
removespace (){
FOO="$1"
FOO_NO_TRAIL_SPACE="$(echo -e "${FOO}" | sed -e 's/[[:space:]]*$//')"
#echo -e "FOO_NO_TRAIL_SPACE='${FOO_NO_TRAIL_SPACE}'"

FOO_NO_SPACE="$(echo -e "${FOO_NO_TRAIL_SPACE}" | sed -e 's/^[[:space:]]*//')"
echo "${FOO_NO_SPACE}"

#echo -e "length(FOO_NO_TRAIL_SPACE)==$(echo -ne "${FOO_NO_SPACE}" | wc -m)"
# > length(FOO_NO_TRAIL_SPACE)==15
}

metapath="/media/sf_ubuntu/mp3soph/";

echo "extracting meta data from $1";

temp=$(exiftool -title "$1");
title="$(removespace "${temp##*:}")";
echo "title :**$title**";
: ||{
temp=$(exiftool -artist "$1" | sed -e 's/  [ \t]\/\;\?//g') ;
artist="${temp##*:}"
temp=$(exiftool -album "$1" | sed -e 's/  [ \t]\/\;\?//g'| tr -d '[\;\\\/]') ;
album="${temp##*:}"
temp=$(exiftool -genre "$1" | sed -e 's/  [ \t]\/\;\?//g') ;
genre="${temp##*:}"
temp=$(exiftool -date "$1" | sed -e 's/  [ \t]\/\;\?//g' | tr -d '[[:space:]]') ;
date="${temp##*:}"
temp=$(exiftool -year "$1" | sed -e 's/  [ \t]\/\;\?//g') ;
year="${temp##*:}"
echo	"************** title= $title artist=$artist $album $genre $date $year" ;
name="${1##*/}";

ext="$(echo '${1##*.}'| tr -d '[[:space:]]')";
filename="$(echo "$artist" | sed -e's/[^a-zA-Z0-9]//g')-$(echo "$title" | sed -e's/[^a-zA-Z0-9]//g').mp3"

t="$(echo "$title" | tr -d '[[:space:]]')";
a="$(echo "$title" | tr -d '[[:space:]]')"
if [  -z "$t"  -a  -z "$a"  ] ; then
	
		echo "metadata empty";
else
		
		echo "writing .... in $metapath$filename ...";
		writeffmpeg "$1";
fi

}






