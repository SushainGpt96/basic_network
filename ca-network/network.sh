#!/bin/bash

if [ -d "organizations/peerOrganizations" ]; then
  rm -Rf organizations/peerOrganizations && rm -Rf organizations/ordererOrganizations
fi

echo
echo "##########################################################"
echo "##### Generate certificates using Fabric CA's ############"
echo "##########################################################"

docker-compose -f docker-compose-ca.yaml up -d

. organizations/fabric-ca/registerEnroll.sh

sleep 10
 
echo "##########################################################"
echo "############ Create city1 Identities ######################"
echo "##########################################################"

createcity1

echo "##########################################################"
echo "############ Create city2 Identities ######################"
echo "##########################################################"

createcity2

echo "##########################################################"
echo "############ Create city3 Identities ######################"
echo "##########################################################"

createcity3

echo "##########################################################"
echo "############ Create Orderer Org Identities ###############"
echo "##########################################################"

createOrderer

echo
echo "Generate CCP files for cities"
./organizations/ccp-generate.sh