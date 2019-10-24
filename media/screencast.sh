#!/bin/bash

PIDFILE=${HOME}/.screencast_pid

if [ -f ${PIDFILE} ]; then
    PID=$(cat ${PIDFILE})
    if [ -n "$(ps -p ${PID} -o pid=)" ]; then
        echo "Screencast in progress" | dmenu
        WD=$(readlink -f /proc/${PID}/cwd)
        OUTFILE=${WD}/output.mp4
        kill ${PID}
        rm ${PIDFILE}
        vlc ${OUTFILE}
        exit 1
    else
        echo "wrong pidfile"
        rm ${PIDFILE}
    fi
fi

get_mouse_location() {
    echo "Go to $1 then press Enter." | dmenu > /dev/null
    xdotool getmouselocation
}

tlc=$(get_mouse_location "top left corner")
brc=$(get_mouse_location "bottom right corner")

top=$(echo ${tlc} | sed -e "s/.*y:\([0-9]\+\).*/\1/")
lef=$(echo ${tlc} | sed -e "s/.*x:\([0-9]\+\).*/\1/")
bot=$(echo ${brc} | sed -e "s/.*y:\([0-9]\+\).*/\1/")
rig=$(echo ${brc} | sed -e "s/.*x:\([0-9]\+\).*/\1/")

width=$(expr ${rig} - ${lef})
height=$(expr ${bot} - ${top})
echo "Do screencast ${width}x${height} from top: ${top} left: ${lef} to bottom: ${bot} right: ${rig}"

ffmpeg -v 8 -video_size ${width}x${height} -framerate 10 -y -f x11grab -i :0.0+${lef},${top} output.mp4 &
FFMPEG_PID=$!
echo ${FFMPEG_PID} > ${PIDFILE}
