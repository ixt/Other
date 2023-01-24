#!/bin/bash
input=$1
pointsize=1500

while IFS=',' read -a line; do
    if [[ ! -s "./output/${line}.png" ]]; then
        convert -background transparent \
                -pointsize $pointsize \
                -strokewidth 50 \
                -stroke black \
                -font 'Nimbus-Sans-L-Bold' \
                -fill orangered label:"${line}" \
                -trim +repage \
                -resize 640x370 \
                "./output/${line}.png"
        # composite -gravity center "./output/${line[0]}.png" sun.png next.png
        # mv next.png "./output/${line[0]}.png"
        echo $line
    fi
done < <(seq 6000 -1 1 | shuf)
