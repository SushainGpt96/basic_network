#!/bin/bash

docker rm -f $(docker ps -aq)
docker image prune
docker volume prune
docker ps -a
docker image


docker kill $(docker ps -q)
docker rm $(docker ps -q)
set -a
source .env

rm -rf organizations/ordererOrganizations
rm -rf organizations/peerOrganizations
rm -rf organizations/fabric-ca/city1
rm -rf organizations/fabric-ca/city2
rm -rf organizations/fabric-ca/city3
rm -rf organizations/fabric-ca/ordererOrg


