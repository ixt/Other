#!/bin/bash
input="$1"
lastframe=$(tail -1 $input | cut -d, -f1)
lastvalue=""
for i in $(seq 0 $lastframe); do
    IFS=',' read -a line < <(grep "^$i," $input)
    if [[ ${line[0]} != '' ]]; then
        lastvalue="${line[1]}"
    fi
    echo "$i,$lastvalue"
done
