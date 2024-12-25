#!/usr/bin/env bash

ffmpeg -re \
    -i /srv/dev/mixyboos/working/media/bbb.mp4 \
    -c copy \
    -f flv rtmp://live-mixyboos.dev.fergl.ie:1935/live/YfbUdfzcgjgIXvUaNZ3X9lQoyhdEc6nc
