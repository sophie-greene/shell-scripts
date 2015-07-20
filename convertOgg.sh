#!/bin/bash
f1=$1;

    OUTF=$(echo "$f1" | sed s/\.m4a/.ogg/g)

    ARTIST=$(faad -i "$f1" 2>&1 | grep '^artist: ' | sed 's/^artist: //')
    TITLE=$(faad -i "$f1" 2>&1 | grep '^title: ' | sed 's/^title: //')
    ALBUM=$(faad -i "$f1" 2>&1 | grep '^album: ' | sed 's/^album: //')
    GENRE=$(faad -i "$f1" 2>&1 | grep '^genre: ' | sed 's/^genre: //')
    TRACKNUMBER=$(faad -i "$f1" 2>&1 | grep '^track: ' | sed 's/^track: //')
    DATE=$(faad -i "$f1" 2>&1 | grep '^date: ' | sed 's/^date: //')

    faad "$f1"
    oggenc -q 6 -d "$DATE" -t "$TITLE" -N "$TRACKNUMBER" -a "$ARTIST" -l "$ALBUM" -G "$GENRE" "${m4afile%.*}.mp3"
    #rm "${m4afile%.*}.mp3"
  done
