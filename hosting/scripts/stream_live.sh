#!/usr/bin/env bash

HOST=rtmp://live.mixyboos.com/live/YfbUdfzcgjgIXvUaNZ3X9lQoyhdEc6nc
STREAM_FILE=/srv/dev/mixyboos/working/media/bbb.mp4

echo Starting stream
ffmpeg -stream_loop -1 -re \
    -i $STREAM_FILE \
    -c copy \
    -f flv \
    $HOST

# ffmpeg \
#     -i $STREAM_FILE \
#     -r 30 -f lavfi -i testsrc -vf scale=1024:576 \
#     -vcodec libx264 -profile:v baseline -pix_fmt \
#     yuv420p -f flv \
#     $HOST
