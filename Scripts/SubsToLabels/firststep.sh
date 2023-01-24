#!/bin/bash
IFS=","
FRAMERATE="2400"
while read -a row; do
    while IFS=':.' read -a time; do
        : $(( time[2] *= 1000))
        : $(( time[1] *= (1000 * 60 )))
        : $(( time[0] *= (1000 * 60 * 60 )))
        value=$(bc -l <<< "($(echo ${time[@]} | sed -e "s/ / + /g" ) )* ($FRAMERATE/1000)"| cut -d. -f1)
        [[ $value != 0 ]] && echo $value,${row[1]}
    done < <(echo ${row[0]} | sed -e "s/[:.]0\([0-9]\)/:\1/g;s/^0//g")
done < <(grep "<" "./$1" \
    | sed -e "s/<\/c>/\n/g" \
          -e "s/^[^<]*</</" \
          -e "s/<c>//g" \
          -e "s/> /,/g" \
          -e "s/>/,/g" \
          -e "s/<//g")

