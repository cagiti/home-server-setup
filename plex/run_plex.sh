#!/bin/bash
sudo docker stop plex
sudo docker rm plex
sudo docker run -d \
                -h cartref \
                -v /opt/plex/config:/config \
                -v /opt/plex/media:/data \
                -p 32400:32400 \
                -p 1900:1900/udp \
                -p 32410:32410/udp \
                -p 32412:32412/udp \
                -p 32413:32413/udp \
                -p 32414:32414/udp \
                -p 32469:32469 \
                --name plex \
                --net=host timhaak/plex:latest
