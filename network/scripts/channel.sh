#!/bin/bash

export CORE_PEER_LOCALMSPID=city1MSP
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/crypto/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto/peerOrganizations/city1.product.com/users/Admin@city1.product.com/msp
export CORE_PEER_ADDRESS=peer0.city1.product.com:7051
export ORDERER_CA=${PWD}/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

peer channel create -f channel-artifacts/productchannel.tx -c productchannel -o orderer.product.com:7050 --tls --cafile $ORDERER_CA
peer channel join -b productchannel.block
peer channel update -o orderer.product.com:7050 -c productchannel -f channel-artifacts/city1Anchor.tx --tls --cafile $ORDERER_CA

export CORE_PEER_LOCALMSPID=city2MSP
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/crypto/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto/peerOrganizations/city2.product.com/city2/Admin@city2.product.com/msp
export CORE_PEER_ADDRESS=peer0.city2.product.com:9051
export ORDERER_CA=${PWD}/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

peer channel join -b productchannel.block
peer channel update -o orderer.product.com:7050 -c productchannel -f channel-artifacts/city2Anchor.tx --tls --cafile $ORDERER_CA

export CORE_PEER_LOCALMSPID=city3MSP
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/crypto/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto/peerOrganizations/city3.product.com/city3/Admin@city3.product.com/msp
export CORE_PEER_ADDRESS=peer0.city3.product.com:11051
export ORDERER_CA=${PWD}/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

peer channel join -b productchannel.block
peer channel update -o orderer.product.com:7050 -c productchannel -f channel-artifacts/city3Anchor.tx --tls --cafile $ORDERER_CA