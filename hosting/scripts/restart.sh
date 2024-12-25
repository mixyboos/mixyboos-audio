#!/usr/bin/env bash

HOST=rtmp://live-mixyboos.dev.fergl.ie:1935/live/YfbUdfzcgjgIXvUaNZ3X9lQoyhdEc6nc
STREAM_FILE=/srv/dev/mixyboos/working/media/bbb.mp4

echo Clearing previous streams
sudo rm -rf ./mounts/audio/streams/hls/*
sudo rm -rf ./mounts/audio/streams/dash/*
sudo rm -rf ./mounts/audio/archived/*
sudo rm -rf ./mounts/audio/recordings/processed/*
sudo rm -rf ./mounts/audio/recordings/processing/*

echo Clearing logs
sudo rm -rf ./mounts/log/*

echo Stopping existing containers
docker --context default compose -f ./docker-compose.local.yml stop

echo Spin up
docker --context default compose -f ./docker-compose.local.yml pull &&
    docker --context default compose -f ./docker-compose.local.yml up -d &&
    docker --context default compose -f ./docker-compose.local.yml logs -f
    # docker --context default compose -f ./docker-compose.local.yml up -d &&
    # docker --context default compose -f ./docker-compose.local.yml logs -f
