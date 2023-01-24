#!/bin/bash
ORG="$1"
firststep="$2"

IFS=' ' read -a ORGARR < <(cat $ORG \
    | tr '[:upper:]' '[:lower:]' \
    | sed -e "s/[,.'’]//g;s/\n//g" \
    | tr -d '\r\n|\n\r|\n|\r')

ORGPLACE=0
lastcol=''
DEBUG=
while IFS=', ' read -a line; do
    _col=0
    buildline=''
    prependline=''
    matchfound=0
    blankcol=0
    SKIPLINE=0
    for col in ${line[@]}; do
        # [[ ${line[0]} == '261' ]] && DEBUG=0
        if [[ $_col != 0 ]]; then
            if [[ $col == ${ORGARR[$ORGPLACE]} ]]; then
                [[ $buildline != '' ]] && buildline="$buildline $col"
                [[ $buildline == '' ]] && buildline="$col"
                [[ $DEBUG ]] && echo perfect line
                : $(( ORGPLACE += 1 ))
            else
                while [[ $col != ${ORGARR[$ORGPLACE]} ]]; do
                    if [[ $lastcol != ${ORGARR[$ORGPLACE]} && $col != ${ORGARR[$ORGPLACE+1]} && ${ORGARR[$ORGPLACE+1]} != ${ORGARR[$ORGPLACE-1]} ]]; then
                        [[ $DEBUG ]] && echo '(past)' "($lastcol)" $col ${ORGARR[$ORGPLACE]} "[next: ${ORGARR[$ORGPLACE+1]}]"
                        matchfound=0
                        for i in $(seq 1 5); do
                            if [[ "$col" == ${ORGARR[$ORGPLACE+i]} ]]; then
                                [[ $DEBUG ]] && echo "match found"
                                matchfound=1
                                break
                            fi
                        done
                        [[ $matchfound == 0 ]] && matchfound=2
                        [[ $matchfound == 2 && $buildline != '' ]] && buildline="$buildline ${ORGARR[$ORGPLACE]}"
                        [[ $matchfound == 2 && $buildline == '' ]] && buildline="${ORGARR[$ORGPLACE]}"
                        [[ $matchfound == 1 && $prependline != '' ]] && prependline="$prependline ${ORGARR[$ORGPLACE]}"
                        [[ $matchfound == 1 && $prependline == '' ]] && prependline="${ORGARR[$ORGPLACE]}"
                        : $(( ORGPLACE += 1 ))
                        [[ $matchfound == 1 ]] && continue
                        break
                    else
                        [[ $DEBUG ]] && echo "($lastcol)" $col ${ORGARR[$ORGPLACE]} "[next: ${ORGARR[$ORGPLACE+1]}]"
                        if [[ $lastcol != ${ORGARR[$ORGPLACE]} && $col != ${ORGARR[$ORGPLACE+1]} ]]; then
                            [[ $prependline != '' ]] && prependline="$prependline ${ORGARR[$ORGPLACE]}"
                            [[ $prependline == '' ]] && prependline="${ORGARR[$ORGPLACE]}"
                            [[ $DEBUG ]] && echo not last, not next
                        elif [[ $lastcol != ${ORGARR[$ORGPLACE]} && $col == ${ORGARR[$ORGPLACE+1]} ]]; then
                            [[ $prependline != '' ]] && prependline="$prependline ${ORGARR[$ORGPLACE]}"
                            [[ $prependline == '' ]] && prependline="${ORGARR[$ORGPLACE]}"
                            [[ $DEBUG ]] && echo not last, is next
                        elif [[ $lastcol == ${ORGARR[$ORGPLACE]} && $col == ${ORGARR[$ORGPLACE+1]} ]]; then
                            [[ $prependline != '' ]] && prependline="$prependline ${ORGARR[$ORGPLACE]}"
                            [[ $DEBUG ]] && echo is last, is next
                        fi
                    fi 
                    : $(( ORGPLACE += 1 ))
                done
                [[ $blankcol == 1 ]] && matchfound=2
                [[ $matchfound == 0 && $buildline == '' && $prependline != '' ]] && buildline="$prependline" && prependline=''
                [[ $matchfound == 0 && $buildline != '' && $prependline != '' ]] && buildline="$prependline $buildline $col" && prependline=''
                [[ $matchfound == 0 && $buildline != '' && $prependline == '' ]] && buildline="$buildline $col"
                [[ $matchfound == 0 && $buildline == '' && $prependline == '' ]] && buildline="$col"

                [[ $matchfound == 1 && $buildline == '' && $prependline != '' ]] && buildline="$prependline" && prependline=''
                [[ $matchfound == 1 && $buildline != '' && $prependline != '' ]] && buildline="$prependline $buildline" && prependline=''
                [[ $matchfound == 1 && $buildline != '' && $prependline == '' ]] && buildline="$buildline $col"

                [[ $matchfound == 2 && $buildline == '' && $prependline != '' ]] && buildline="$prependline" && prependline=''
                [[ $matchfound == 2 && $buildline != '' && $prependline != '' ]] && buildline="$prependline $buildline" && prependline=''
                [[ $matchfound == 2 && $buildline != '' && $prependline == '' ]] && buildline="$buildline"
                blankcol=0
            fi
            [[ $buildline == $lastcol ]] && SKIPLINE=1
            lastcol=$col
        fi
        : $(( _col += 1 ))
    done
    [[ $SKIPLINE != 1 ]] && echo "${line[0]},$buildline"
done < $firststep
