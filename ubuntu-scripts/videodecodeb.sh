#!/bin/bash
echo $1;
echo $2;
echo $3;
echo $4;
echo $5;
echo $6;

ffmpeg -i $1 -vcodec libx264 -crf 20 -metadata title=$3 -metadata artist=$4 -metadata comment=$5 -metadata copyright=$6 -metadata encoder=$7 $2;
#ffmpeg -i input.mp4 -vcodec libx264 -crf 20 output.mp4

