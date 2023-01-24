#!/bin/bash

tokenToWatch="69023900"
tempFile=$(mktemp)
seenFile="./$tokenToWatch.seen"
balanceFile="./$tokenToWatch.bal"
whitelistFile="./april.white"
LOG="./$tokenToWatch.log"
CHECKED_HASH="./$tokenToWatch.operations"
IFS=","
fundingAccount="event"
fundingAddress="tz1aTMqZxqucFUpkuwKjCTCGQCdyxvFRmBUg"
BURN="tz1burnburnburnburnburnburnburjAYjjX"
HEN="KT1RJ6PbjHpwc3M5rw5s2Nbmefwbuwbdxton"
totalBalance=0

function send_objkt(){
    local target=$1
    local contract=$2
    local object=$3
    local amount=${4:-1}
    echo "$ACCPASS
" | tezos-client transfer 0 from $fundingAddress to $contract --entrypoint transfer --arg "{Pair \"$fundingAddress\" {Pair \"$target\" (Pair $object $amount)}}" --burn-cap 1
    
}

while read -a token; do
    send_objkt ${token[1]} ${token[0]} ${token[2]} ${token[3]}
    sleep 30s
done < $1
