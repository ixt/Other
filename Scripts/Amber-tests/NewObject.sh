#!/usr/bin/env bash
# CC-0 Ixtli Orange 2019
ObjectFile="test.json"
tmp_ObjectFile=$(mktemp)

trap clean_up SIGHUP SIGINT SIGTERM 
clean_up(){
    rm -f $tmp_ObjectFile
    printf "goodbye have a nice day\n"
    exit 0
}

# objid
# name
# date_accuracy
# date_acquired
# date_removed
# description
# location
# location_acquired
# quantity
# review
# type
# version
# weight
# weight_units

objid="000"
name="N/A"
date_accuracy="N/A"
date_acquired="N/A"
date_removed="N/A"
description="N/A"
location="N/A"
location_acquired="N/A"
quantity="N/A"
review="N/A"
itype="N/A"
version="N/A"
weight="N/A"
weight_units="N/A"

write_objectfile(){
    cat <<EOF >$tmp_ObjectFile
{
    "objid" : "$objid",
    "name" : "$name",
    "date_accuracy" : "$date_accuracy",
    "date_acquired" : "$date_acquired",
    "date_removed" : "$date_removed",
    "description" : "$description",
    "location" : "$location",
    "location_acquired" : "$location_acquired",
    "quantity" : "$quantity",
    "review" : "$review",
    "type" : "$itype",
    "version" : "$version",
    "weight" : "$weight",
    "weight_units" : "$weight_units"
}
EOF
ObjectFile="$objid-${name// /_}.json"
}

do_form(){
    VALUES=( $(dialog --form "New Object" 0 0 0 \
objid             1  0 "$objid"             1  19 10 0 \
name              2  0 "$name"              2  19 10 0 \
date_accuracy     3  0 "$date_accuracy"     3  19 10 0 \
date_acquired     4  0 "$date_acquired"     4  19 10 0 \
date_removed      5  0 "$date_removed"      5  19 10 0 \
description       6  0 "$description"       6  19 10 0 \
location          7  0 "$location"          7  19 10 0 \
location_acquired 8  0 "$location_acquired" 8  19 10 0 \
quantity          9  0 "$quantity"          9  19 10 0 \
review            10 0 "$review"            10 19 10 0 \
itype             11 0 "$itype"             11 19 10 0 \
version           12 0 "$version"           12 19 10 0 \
weight            13 0 "$weight"            13 19 10 0 \
weight_units      14 0 "$weight_units"      14 19 10 0 \
    3>&1 1>&2 2>&3 | sed -e "s/ /@/g"))
objid="${VALUES[0]//@/ }"
name="${VALUES[1]//@/ }"
date_accuracy="${VALUES[2]//@/ }"
date_acquired="${VALUES[3]//@/ }"
date_removed="${VALUES[4]//@/ }"
description="${VALUES[5]//@/ }"
location="${VALUES[6]//@/ }"
location_acquired="${VALUES[7]//@/ }"
quantity="${VALUES[8]//@/ }"
review="${VALUES[9]//@/ }"
itype="${VALUES[10]//@/ }"
version="${VALUES[11]//@/ }"
weight="${VALUES[12]//@/ }"
weight_units="${VALUES[13]//@/ }"
    write_objectfile
    cat $tmp_ObjectFile
}

do_about() {
    dialog --msgbox "
        This script is to aide in creating an amber database \
        " 0 0
}


#
# Interactive loop
#

do_form
exit 0

while true; do
    FUN=$(dialog --title "New Object Amber" --menu "options" 0 0 0 \
    0 "About" \
    1 "New" \
    3>&1 1>&2 2>&3)
    RET=$?
    echo $FUN
    if [ $RET -eq 1 ]; then
        exit 0
    elif [ $RET -eq 0 ]; then
        case "$FUN" in
            0) do_about ;;
            1) do_form ;;
            *) exit 0 ;;
        esac
    else
        exit 1
    fi
done

