#!/bin/bash
MEDIA=/tmp
#MEDIA=/opt/plex/media
TV_SHOWS="${MEDIA}/TV Shows"
GET_IPLAYER=./get_iplayer/get_iplayer

#remove old history
rm -rf ~/.get_iplayer

if [ ! -d "${TV_SHOWS}/${programme}" ]; then
    echo "No directory exists for ${programme}, creating!"
    mkdir -p "${TV_SHOWS}/${programme}"
fi

while read programme; do
    echo "getting programme id's for ${programme}"
    ids=`${GET_IPLAYER} "${programme}" | \
      awk -F' ' '
        BEGIN {
          list=""
        }
        /^[0-9]+:.*$/ {
          sub(":"," ",$1)
          list=list $1
        }
        END {
          print list
        }'`

    cd "${TV_SHOWS}/${programme}"
    echo "Getting ${programme} using ${ids}"
    
    ${GET_IPLAYER} $ids --get --tvmode=best
done < ./rhaglennu
