#!/usr/bin/env bash

HOST=rtmp://live-mixyboos.dev.fergl.ie:1935/live/YfbUdfzcgjgIXvUaNZ3X9lQoyhdEc6nc
STREAM_FILE=/srv/dev/mixyboos/working/media/bbb.mp4

echo Starting stream
ffmpeg -stream_loop -1 -re \
    -i $STREAM_FILE \
    -c copy \
    -f flv \
    $HOST


sudo rm -rfv /srv/dev/mixyboos/mixyboos-audio/mounts/audio/streams/hls/*
sudo rm -rfv /srv/dev/mixyboos/mixyboos-audio/mounts/audio/streams/dash/*
# ffmpeg \
#     -i $STREAM_FILE \
#     -r 30 -f lavfi -i testsrc -vf scale=1024:576 \
#     -vcodec libx264 -profile:v baseline -pix_fmt \
#     yuv420p -f flv \
#     $HOST
