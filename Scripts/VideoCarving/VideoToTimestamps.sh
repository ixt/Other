#!/bin/bash
youtube-dl --id --write-auto-sub --skip-download https://www.youtube.com/watch?v=$ID
cat $ID.en.vtt | grep '<c>' | sed -e 's/<c>/\n/g' -e 's/<\/c>//g' | sed -e 's/</,/g' -e 's/>//g' -e 's/^ //g' | grep ',' | sort > $ID.list

