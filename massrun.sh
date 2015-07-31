#!/bin/bash
#rename images according to creation  date
curr="$(pwd)"
cd "$1";
mkdir /home/some/out4/
counter=1;
for i in *
do
echo "$i"
	mod_date=$(identify -format "%[exif:DateTimeOriginal] " "$i"|sed 's/\..*$//'| sed 's/[^0-9]//g')
#s=$(identify -format "%d" "$i");
	echo " $i--> ../out2/img$mod_date-$counter.png "
aspect=$(identify -format "%[fx:w/h]" "$i");
#aspect=$(echo "$a" | bc -l);
if [ $(echo " $aspect > 1 " | bc) -eq 1 ] ; then
	convert  "$i"  -resize 2048^x1536^ -pointsize 60 -fill darkred -draw 'text 55,55 "William Petta"' -gravity center -extent 2048x1536  "/home/some/out4/img$mod_date-$counter.png" &
	
else 
	convert  "$i"  -resize 1152^x1536^   -pointsize 60 -fill darkred -draw 'text 55,55 "William Petta"' -gravity center -extent 2048x1536   "/home/some/out4/img$mod_date-$counter.png" &
#convert -pointsize 50 -fill blue -draw 'text 10,10 "Happy Birthday William Petta"'
fi
#ffmpeg -i "$i" -vf scale="'if(gt(a,16/9),1024,-1)':'if(gt(a,16/9),-1,576)'" "../out1/img$mod_date.png"

	#cp "$i" "../out1/I$mod_date.JPG"
let counter=$counter+1;
done
cd "$curr"
