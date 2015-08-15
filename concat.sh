#!/bin/bash


j=0
find /media/sf_ubuntu/video/ -name "*.mp4" >files.txt
while read FILE; 
do 

t1="$(stat -c '%s' "$FILE")"; 
t2="$(stat -c '%n' "$FILE")";
ffmpeg -i "$FILE" -c copy -bsf:v h264_mp4toannexb -f mpegts "it$j.ts"
j+=1
done <files.txt

ffmpeg -i concat:it*.tx -c copy -bsf:a aac_adtstoasc output.mp4


