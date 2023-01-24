#!/bin/bash
/bin/date +"%Y.%m.%d" > /Users/nfnorange/Documents/todaysdate.txt
/opt/homebrew/bin/convert \
	-font "Times-Bold" \
	\( -background black -pointsize 1000 -fill white label:"SHOW" -trim +repage -resize 1080x520! \) \
	\( -background transparent -pointsize 1500 -fill orangered label:"$(/bin/date +'%Y%m%d')" -trim +repage -resize 1080x520! \)\
	-flatten -trim \
	+repage \
	-resize 1080x520! \
	-bordercolor black \
	-border 100x100 "todays-thumbnail.png"
