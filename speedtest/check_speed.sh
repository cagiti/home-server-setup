#!/bin/bash

    ./speedtest | \
    awk -F' ' '
	BEGIN {
		time=strftime()
		download=0
		upload=0
	}
	/^Download.*$/ {
		download=$2
	}
	/^Upload.*$/ {
		upload=$2
	} 
	END{
		print time ": " download " " upload
	}' >> ./broadband_speed.log
