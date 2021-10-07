#!/bin/bash
rm -rf channel-artifacts/*
export FABRIC_CFG_PATH=$PWD

# Generate System Genesis block

configtxgen -outputBlock channel-artifacts/genesis.block -channelID ordererchannel -profile OrdererChannel

# Generate channel configuration block

configtxgen -outputCreateChannelTx channel-artifacts/productchannel.tx -channelID productchannel -profile productchannel

echo "#######    Generating anchor peer update for city1MSP  ##########"

configtxgen --outputAnchorPeersUpdate channel-artifacts/city1Anchor.tx -channelID productchannel -profile productchannel -asOrg city1MSP

echo "#######    Generating anchor peer update for city2MSP  ##########"

configtxgen --outputAnchorPeersUpdate channel-artifacts/city2Anchor.tx -channelID productchannel -profile productchannel -asOrg city2MSP

echo "#######    Generating anchor peer update for city3MSP  ##########"

configtxgen --outputAnchorPeersUpdate channel-artifacts/city3Anchor.tx -channelID productchannel -profile productchannel -asOrg city3MSP
