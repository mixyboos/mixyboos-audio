#!/usr/bin/env bash

echo Stopping existing containers
docker --context noodles compose stop

echo Spin up
export $CONF_FILE=nginx.conf
docker --context noodles compose -f docker-compose.live.yml build --build-arg conf_file=nginx.conf &&
    docker --context noodles compose -f docker-compose.live.yml up -d &&
    docker --context noodles compose -f docker-compose.live.yml logs -f
