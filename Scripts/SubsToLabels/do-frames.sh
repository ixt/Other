#!/bin/bash
input=$1
pointsize=1500

while IFS=',' read -a line; do
    if [[ ! -s "./output/${line[0]}.png" ]]; then
        convert -background transparent \
                -pointsize $pointsize \
                -strokewidth 50 \
                -stroke black \
                -font 'Nimbus-Sans-L-Bold' \
                -fill orangered label:"${line[1]}" \
                -trim +repage \
                -resize 500x500 \
                -bordercolor transparent \
                "./output/${line[0]}.png"
        # composite -gravity center "./output/${line[0]}.png" sun.png next.png
        # mv next.png "./output/${line[0]}.png"
    fi
done < $input
