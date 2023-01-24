#!/bin/bash
cut_file(){ 
        IN_FILE="$1"
        OUT_FILE_FORMAT="$3"
        typeset -i CHUNK_LEN
        CHUNK_LEN="600"
         
        DURATION_HMS=$(ffmpeg -i "$IN_FILE" 2>&1 | grep Duration | cut -f 4 -d ' ')
        DURATION_H=$(echo "$DURATION_HMS" | cut -d ':' -f 1)
        DURATION_M=$(echo "$DURATION_HMS" | cut -d ':' -f 2)
        DURATION_S=$(echo "$DURATION_HMS" | cut -d ':' -f 3 | cut -d '.' -f 1)
        let "DURATION = ( DURATION_H * 60 + DURATION_M ) * 60 + DURATION_S"
         
         
        if [ "$CHUNK_LEN" = "0" ] ; then
                echo "Invalid chunk size"
                usage
                exit 2
        fi
         
        if [ -z "$OUT_FILE_FORMAT" ] ; then
                FILE_EXT=$(echo "$IN_FILE" | sed 's/^.*\.\([a-zA-Z0-9]\+\)$/\1/')
                FILE_NAME=$(echo "$IN_FILE" | sed 's/^\(.*\)\.[a-zA-Z0-9]\+$/\1/')
                OUT_FILE_FORMAT="${FILE_NAME}-%03d.${FILE_EXT}"
                echo "Using default output file format : $OUT_FILE_FORMAT"
        fi
         
        N='1'
        OFFSET='0'
        let 'N_FILES = DURATION / CHUNK_LEN + 1'
         
        while [ "$OFFSET" -lt "$DURATION" ] ; do
                OUT_FILE=$(printf "$OUT_FILE_FORMAT" "$N")
                echo "writing $OUT_FILE ($N/$N_FILES)..."
                ffmpeg -i "$IN_FILE" -vcodec copy -acodec copy -ss "$OFFSET" -t "$CHUNK_LEN" "$OUT_FILE"
                let "N = N + 1"
                let "OFFSET = OFFSET + CHUNK_LEN"
        done
}

mkdir new_clips
# while read folder; do
for folder in 103ORBIV 104ORBIV 105ORBIV 106ORBIV 107ORBIV 108ORBIV 109ORBIV 110ORBIV 111ORBIV 112ORBIV 113ORBIV 114ORBIV 118ORBIV 119ORBIV 120ORBIV 121ORBIV 122ORBIV 123ORBIV 124ORBIV 125ORBIV 126ORBIV 127ORBIV 128ORBIV 129ORBIV 130ORBIV 131ORBIV 132ORBIV 133ORBIV 134ORBIV 135ORBIV; do
pushd $folder
        mkdir 001 002 003
        cp *.CFG 001/
        cp *.CFG 002/
        cp *.CFG 003/
        cp *.BIN 001/
        cp *.BIN 002/
        cp *.BIN 003/

        cut_file PRIM0001.MP4 600         
        cut_file PRIM0002.MP4 600         
        cut_file PRIM0003.MP4 600         
        cut_file PRIM0004.MP4 600         

        mv *-001* 001/
        mv *-002* 002/
        mv *-003* 003/

        for affix in 001 002 003; do
        pushd $affix
                length=$(ffprobe -v error -show_format *1-$affix.MP4 \
                        | grep duration \
                        | sed "s/.*=//g;s/\.//g;s/000$//g")
                jq ".duration = \"$length\"" *.CFG | sponge *.CFG

                file1=$(ffprobe -v error -show_format *1-$affix.MP4 \
                        | grep size | sed "s/.*=//g")
                file2=$(ffprobe -v error -show_format *2-$affix.MP4 \
                        | grep size | sed "s/.*=//g")
                file3=$(ffprobe -v error -show_format *3-$affix.MP4 \
                        | grep size | sed "s/.*=//g")
                file4=$(ffprobe -v error -show_format *4-$affix.MP4 \
                        | grep size | sed "s/.*=//g")

                jq ".sources[1].fileSize = \"$file1\"" *.CFG | sponge *.CFG
                jq ".sources[1].fileSize = \"$file2\"" *.CFG | sponge *.CFG
                jq ".sources[2].fileSize = \"$file4\"" *.CFG | sponge *.CFG
                jq ".sources[3].fileSize = \"$file3\"" *.CFG | sponge *.CFG
                sed -i "s/\.MP4/-$affix.MP4/g" *.CFG
        popd
        done
        mv 001 ../new_clips/$folder-001
        mv 002 ../new_clips/$folder-002
        mv 003 ../new_clips/$folder-003
popd
done
# done < <(ls -1d 1*)


