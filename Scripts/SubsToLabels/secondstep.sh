#!/bin/bash
IFS=','
penultimateframe='0'
penultimatevalue=''
lastframe='0'
lastvalue=''
while read -a row;do
    if [[ $lastvalue == '' ]]; then
        lastvalue="${row[1]}"
        lastframe="${row[0]}"
        continue
    fi
    if [[ $penultimatevalue == '' ]]; then
        printf "$lastframe:($lastvalue: 1 | ${row[1]}: 0),"
        penultimateframe="$lastframe"
        penultimatevalue="$lastvalue"
        lastvalue="${row[1]}"
        lastframe="${row[0]}"
        continue
    fi
    printf "$lastframe:($penultimatevalue: 0| $lastvalue: 1 | ${row[1]}: 0),"
    penultimateframe="$lastframe"
    penultimatevalue="$lastvalue"
    lastvalue="${row[1]}"
    lastframe="${row[0]}"
done < $1
printf "$lastframe:($penultimatevalue: 0 | $lastvalue: 1)"
