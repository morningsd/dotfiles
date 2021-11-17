#!/bin/bash

i3status --config ~/.config/i3status/i3status.conf | while :
do
    read line
    CUR_LG=$(xkblayout-state print "%s")
    LG_STR=$(setxkbmap -query | awk '/layout/{print $2}')
    IFS=',' read -a LG_ARR <<< "$LG_STR"
    if [ ${LG_ARR[0]} == ${CUR_LG} ]
    then
        dat="[{ \"full_text\": \"LANG: ${LG_ARR[0]}\", \"color\":\"#009E00\" },"
    else
	if [ ${LG_ARR[1]} == ${CUR_LG} ]
	then
            dat="[{ \"full_text\": \"LANG: ${LG_ARR[1]}\", \"color\":\"#009E00\" },"
	else
	    if [ ${LG_ARR[2]} == ${CUR_LG} ]
	    then	
	        dat="[{ \"full_text\": \"LANG: ${LG_ARR[2]}\", \"color\":\"#009E00\" },"
	    fi
    	fi
    fi
    echo "${line/[/$dat}" || exit 1
done
