#!/usr/bin/env bash

create_hls_with_master() {
    ffmpeg -y \
        -i files/short.mp3 \
        -c:a aac \
        -b:a 320k \
        -master_pl_name "master.m3u8" \
        -f hls -hls_time 6 -hls_list_size 0 \
        -hls_segment_filename "files/streams/hls/master/v%v/fileSequence%d.m4a" \
        "files/streams/hls/master/v%v/prog_index.m3u8"
}
create_dash_stream() {
    echo Creating Dash stream
    ffmpeg -i files/large.m4a \
        -map 0 -map 0 \
        -c:a aac \
        -c:v libx264 \
        -b:v:0 800k \
        -b:v:1 300k \
        -var_stream_map "v:0,name:800k v:1,name:300k" \
        -f dash \
        -dash_segment_type mp4 \
        -single_file 1 \
        files/streams/output.mpd
}

create_hls_stream() {
    echo Creating HLS stream
    ffmpeg -y \
        -i "files/$1.mp3" \
        -c:a aac \
        -b:a 320k \
        -muxdelay 0 \
        -f segment \
        -sc_threshold 0 \
        -segment_time 7 \
        -segment_list \
        -master_pl_name master.m3u8 \
        -f hls -hls_time 6 -hls_list_size 0 \
        "files/streams/hls/$1/playlist.m3u8" \
        -segment_format mpegts \
        "files/streams/hls/$1/file%d.m4a"
}

__create_hls_stream() {
    echo Creating HLS stream
    ffmpeg -i files/large.mp3 \
        -map 0 \
        -map 0 \
        -c:a aac \
        -b:v:0 800k \
        -b:v:1 300k \
        -var_stream_map "v:0,name:800k v:1,name:300k" \
        -master_pl_name output_manifest.m3u8 \
        -f hls \
        -hls_flags single_file \
        -hls_playlist_type vod \
        -hls_segment_filename "files/streams/hls/output_%v/classroom.ts" \
        streams/hls/output_%v/index.m3u8
}

create_hls_with_master
