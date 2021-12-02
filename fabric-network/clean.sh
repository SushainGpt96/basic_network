#!/bin/bash

docker rm -f $(docker ps -aq)
docker kill $(docker ps -q)
docker image prune
docker volume prune
docker ps -a
docker image

