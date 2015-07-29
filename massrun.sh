#!/bin/bash
#rename images according to creation  date
cd "$1";
mkdir ../out
for i in *
do
echo "$i"
	mod_date=$(identify -format "%[exif:DateTimeOriginal] " "$i"|sed 's/\..*$//'| sed 's/[^0-9]//g')
#s=$(identify -format "%d" "$i");
	echo " $i--> $mod_date.JPG "
	cp "$i" "../out/I$mod_date.JPG"
done
