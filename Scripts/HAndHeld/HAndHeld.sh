#!/usr/bin/env bash
# Utility for dealing with ADB
# CC-0 Ixtli Orange 2019

TEMPPACKAGESDB=$(mktemp)
ignoreSystemApps=1
SCRIPTDIR=$(dirname $0)
APKDIR='APKS'

do_update_package_database(){
    adb shell pm list packages -f \
        > $TEMPPACKAGESDB
    [[ "$?" -ne "0" ]] && exit 1
    [[ "$ignoreSystemApps" -eq "1" ]] && sed -i -e "/\/system\//d" $TEMPPACKAGESDB 
    echo "Packages found: $(cat $TEMPPACKAGESDB | wc -l)"
}

do_download_all_packages(){
    [[ ! -s "$TEMPPACKAGESDB" ]] && do_update_package_database
    pushd ~
    while read PACKAGE; do
        local FILEPATH=$( grep "$PACKAGE" $TEMPPACKAGESDB \
                            | cut -d: -f2- \
                            | egrep -o ".*\.apk" )
        echo "$index: $PACKAGE && $FILEPATH"
        do_android_pull "$FILEPATH" "$APKDIR/$PACKAGE.apk"
    done < <(sed -e "s/.*=//g" $TEMPPACKAGESDB)
    popd
}

do_android_pull(){
    echo "Downloading $1"
    adb pull -p "$1" "$2"
}
adb connect $1
do_download_all_packages

