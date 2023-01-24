#!/bin/bash
#set -o xtrace

tokenToWatch="56"
tempFile=$(mktemp)
seenFile="./$tokenToWatch.seen"
balanceFile="./$tokenToWatch.bal"
whitelistFile="./sept.white"
LOG="./$tokenToWatch.log"
CHECKED_HASH="./$tokenToWatch.operations"
IFS=","
fundingAccount="event"
fundingAddress="tz1aTMqZxqucFUpkuwKjCTCGQCdyxvFRmBUg"
BURN="tz1burnburnburnburnburnburnburjAYjjX"
HEN="KT1NaCcsfX7mAyZ6dUaadaB445sZqVgqh9DY"
BURNBOTDISCORD=""
totalBalance=0

function send_objkt(){
    local target=$1
    local contract=$2
    local object=$3
    local amount=${4:-1}
    echo "$ACCPASS
" | ./tezos-client-1401 transfer 0 from $fundingAddress to $contract --entrypoint transfer --arg "{Pair \"$fundingAddress\" {Pair \"$target\" (Pair $object $amount)}}" --burn-cap 1
    
    sleep 30s
}

function get_token_balances(){
    local tempWhite=$(mktemp)
    count=0
    rm $balanceFile
    cut -d, -f1-2 $whitelistFile > $tempWhite
    curl  --silent "https://api.tzkt.io/v1/tokens/balances?token.standard=fa2&account=$fundingAddress&limit=10000" \
        | jq -r '.[] | [ .token.contract.address, .token.tokenId, .balance ] | @csv' | sed -e 's/"//g' | grep -f $tempWhite > $balanceFile
    local tempBal=$(mktemp)
    sort -u $balanceFile > $tempBal
    cp $tempBal $balanceFile
    rm $tempBal
    totalBalance=0
    while read -a object; do
         local contract=${object[0]}
         local tokenId=${object[1]}
         local balance=${object[2]}

         read -a wl < <(grep "$contract,$tokenId" $whitelistFile)

         # if [[ ${wl[2]} < ${object[2]} ]]; then 
         #     numToBurn=$(( ${object[2]//\"/} - ${wl[2]//\"/}))
         #     echo Burning $numToBurn x $tokenId  
         #     send_objkt $BURN ${contract//\"/} ${tokenId//\"/} $numToBurn
         #     sleep 30s
         # fi
         : $(( totalBalance += ${balance//\"/} ))
    done < $balanceFile 
    echo "[ Total Balance: $totalBalance ]"
    rm $tempWhite 
}

function check_operations(){
   echo "[ Checking Operations ]" 
   local opstatus=""
   local target=""
   local reciever=""
   while read hash; do
       opstatus=""
       check_later=0
       if ! grep -q -wi "$hash" $CHECKED_HASH ; then
        if ! [[ -s "$tokenToWatch/$hash.json" ]]; then
             curl --silent "https://api.tzkt.io/v1/operations/$hash" | jq . | tee $tokenToWatch/$hash.json
             opstatus=$(jq -r '.[] | [.status] | @csv' $tokenToWatch/$hash.json)
        fi
        
        opstatus=$(jq -r '.[] | [.status] | @csv' $tokenToWatch/$hash.json)
        target=$(jq -r '.[] | [.target.address] | @csv' $tokenToWatch/$hash.json)
        case "$opstatus" in
            '"failed"'|'"backtracked"')
                echo "resend/reroll $target ($hash)"
                 if [[ "$target" =~ ^\"KT.* ]] ; then
                     reciever=$(jq -r '.[] | .parameter.value[].txs[].to_' $tokenToWatch/$hash.json)
                     echo $target is contract, $reciever is recipiant $hash | tee -a april.failures
                     # roll $reciever 1
                 else
                     echo resend tezos $reciever $hash | tee -a april.failures
                 fi
             ;;
            '"applied"')
                 echo good to go $target
             ;;
            *)
                 echo "OH NO $opstatus $hash"
                 check_later=1
            ;;
        esac


        if [[ "$check_later" == "0" ]]; then
            echo "$hash,$opstatus" >> $CHECKED_HASH
        else 
            rm $tokenToWatch/$hash.json
        fi
       fi
   done < <(grep 'Operation' $LOG | cut -d"'" -f2 )
}

# function send_tezos(){
#     local target=$1
#     local amount=$2
#     echo "$ACCPASS
# " | ./tezos-client-1401 transfer $amount from $fundingAccount to $target --burn-cap 0.06425
#     
# }

function roll(){
    local target=${1//\"/}
    local amount=${2//\"/}
    local current_edition=0

    get_token_balances  
    echo ROLL $i
    random_edition=$(( $RANDOM % $totalBalance ))
    echo Rolled a $random_edition 
    current_edition=0
    while read -a object; do
        local contract=${object[0]//\"/}
        local tokenId=${object[1]//\"/}
        local balance=${object[2]//\"/}

        : $(( current_edition += balance ))
        if [[ ${current_edition} -gt ${random_edition} ]]; then
            echo "Send Object ${contract}, ${tokenId} to ${target}" | tee -a $LOG | tee >(xargs -I@ ../../../Pkgs/discord.sh/discord.sh --webhook-url "https://discord.com/api/webhooks/1015908564423934003/jKlSfQmvxoOSzr8fiXTLMhq3EsvV3O8RwXBE-S3uOPnIcV7qOtFBlB1e84aNHEKOhcIM" --text "@")
            operation_hash=$(send_objkt ${target} ${contract} ${tokenId} \
                | grep "Operation hash")
            echo "Sent $operation_hash $tokenId to ${entry[1]}!!! $( date)" | tee -a $LOG > >(xargs -I@ ../../../Pkgs/discord.sh/discord.sh --webhook-url "https://discord.com/api/webhooks/1015908564423934003/jKlSfQmvxoOSzr8fiXTLMhq3EsvV3O8RwXBE-S3uOPnIcV7qOtFBlB1e84aNHEKOhcIM" --text "@")
            creator=$(grep "${contract},${tokenId}," $whitelistFile | cut -d, -f 4)
            #echo "send tezos to ${tokenId} (${contract}) creator(s) (${creator})"
            #if [[ "$tokenId" == "19260" && "$contract" == "KT1LjmAdYQCLBjwv4S2oFkEzyHVkomAf5MrW" ]]; then
            #    echo 19260
            #    send_tezos tz1UgSapkB4jZp42adZARjNX8YVk2bmkqH4b 1
            #    send_tezos tz1MkNmLwb8TH868ez1A3VQWhjB2kuzHrHTB 1
            #elif [[ "$tokenId" == "19380" && "$contract" == "KT1LjmAdYQCLBjwv4S2oFkEzyHVkomAf5MrW" ]]; then
            #    echo 19380
            #    send_tezos tz1cpszUhhk11Aif6Hhhh1ASqfpn23wxfvQT 1.85
            #    send_tezos tz1aPHze1U5BEEKrGYt3dvY6aAQEeiWm8jjK 0.1
            #elif [[ "$tokenId" == "19377" && "$contract" == "KT1LjmAdYQCLBjwv4S2oFkEzyHVkomAf5MrW" ]]; then
            #    echo 19377
            #    send_tezos tz1QQyewuZe1KXbXxCRG96UFbsUD7ExFmbbP 1.8
            #    send_tezos tz1gRM27qWwvnSEJwRwLDk37S9kY4w5F3rq5 0.15
            #elif [[ "$tokenId" == "19370" && "$contract" == "KT1LjmAdYQCLBjwv4S2oFkEzyHVkomAf5MrW" ]]; then
            #    echo 19370
            #    send_tezos tz1UR3Npc8ZM5ErYEoo8xE1GV9GRvuVJ2q4z 1
            #    send_tezos tz1Q892Wa8yHu7Hm3kNoon9TKoyhdQ9MZ8Gv 1
            #elif [[ "$tokenId" == "19371" && "$contract" == "KT1LjmAdYQCLBjwv4S2oFkEzyHVkomAf5MrW" ]]; then
            #    echo 19370
            #    send_tezos tz1UR3Npc8ZM5ErYEoo8xE1GV9GRvuVJ2q4z 1
            #    send_tezos tz1Q892Wa8yHu7Hm3kNoon9TKoyhdQ9MZ8Gv 1
            #else
            #    echo "send tezos to ${tokenId} (${contract}) creator(s) (${creator})"
            #    send_tezos $creator 1.95
            #fi
            break
        fi
    done < $balanceFile
    
}

count=0
echo "[ Getting Balances ]" 
get_token_balances
if [[ $totalBalance == 0 ]]; then
    exit 2
fi


while true; do
    check_operations
    #HOURSAGO=$(date --iso-8601="seconds" --date="6 hours ago" | sed -e "s/+.*//g")
    echo "[ Getting transactions ]"
    #curl --silent "https://api.tzkt.io/v1/tokens/transfers?token.contact=${HEN}&token.tokenId=${tokenToWatch}&token.standard=fa2&to=${BURN}&timestamp.gt=${HOURSAGO}Z" \
    #curl --silent "https://api.tzkt.io/v1/tokens/transfers?token.contact=${HEN}&token.tokenId=${tokenToWatch}&token.standard=fa2&to=${BURN}" \
    #    | jq -r '.[] | [.id, .from.address, .amount ] | @csv' > $tempFile
    curl --silent "https://api.tzkt.io/v1/tokens/transfers?token.metadata.image=ipfs://QmT1RoPfGHAvU549yVSWqL32yY6uWCL3Ex3rQnhuAShXBX&token.tokenId=56&token.standard=fa2&to=tz1burnburnburnburnburnburnburjAYjjX&select=id,from.address,amount,timestamp,token.contract.address,token.tokenId&offset=100" \
        | jq -r '.[] | [.id, ."from.address", .amount ] | @csv' > $tempFile
    while read -a entry; do
        if ! grep -q "^${entry[0]}$" $seenFile; then
            echo "[ New Burn !!! ]"
            echo ${entry[1]} ${entry[2]}
            while read i; do
                roll ${entry[1]} 
            done < <(seq 1 ${entry[2]//\"/})
            echo ${entry[0]} >> $seenFile
        fi
    done < $tempFile

    rm $tempFile
    : $(( count += 1 ))
    if [[ $count == 60 ]]; then 
        echo "[ Update whitelist ]"
        get_token_balances
        : $(( count = 0 ))
    fi
    sleep 30s
done

