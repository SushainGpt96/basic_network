#!/bin/bash

if [ -d "organizations/peerOrganizations" ]; then
  rm -Rf organizations/peerOrganizations && rm -Rf organizations/ordererOrganizations
fi

echo
echo "##########################################################"
echo "##### Generate certificates using Fabric CA's ############"
echo "##########################################################"

. organizations/fabric-ca/registerEnroll.sh

sleep 5
 
echo "##########################################################"
echo "############ Create city1 Identities ######################"
echo "##########################################################"

createcity1

echo "##########################################################"
echo "############ Create city2 Identities ######################"
echo "##########################################################"

sleep 5

createcity2

echo "##########################################################"
echo "############ Create city3 Identities ######################"
echo "##########################################################"

sleep 5

createcity3

echo "##########################################################"
echo "############ Create Orderer Org Identities ###############"
echo "##########################################################"

sleep 5

createOrderer

echo
echo "Generate CCP files for cities"
./organizations/ccp-generate.sh