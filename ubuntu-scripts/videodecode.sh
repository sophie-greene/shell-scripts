#!/bin/bash
ffmpeg -i $1 \
#	-map 0:0 -map 0:2 \
	-metadata title='$3' \
	-metadata artist='$4' \
	-metadata comment='$5' \
	-metadata copyrigh='$6' \
#	-target svcd \
$2
#ffmpeg -i input.mp4 -vcodec libx264 -crf 20 output.mp4

