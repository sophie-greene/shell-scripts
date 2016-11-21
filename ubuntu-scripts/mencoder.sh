mencoder <filename.avi> \
   -ovc xvid \
   -oac mp3lame \
   -lameopts abr:br=92 \
   -xvidencopts bitrate=150 \
   -o <output.avi>
