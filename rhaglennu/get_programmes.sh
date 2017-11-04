#!/bin/bash

if [ ! -d "/opt/plex/media/TV Shows/${programme}" ]; then
    echo "No directory exists for ${programme}, creating!"
    mkdir "/opt/plex/media/TV Shows/${programme}"
fi

while read programme; do
    echo "getting programme id's for ${programme}"
    ids=$(get-iplayer "${programme}" | \
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
        }')

    cd "/opt/plex/media/TV Shows/${programme}"
    echo "Getting ${programme} using ${ids}"
    get-iplayer --get $ids --tvmode=best
done < ./rhaglennu
