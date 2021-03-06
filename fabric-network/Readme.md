# Fabric-2.0-Basic-Network(3_Org_6peer_5orderer)

---

**Note: This README presumes that you have installed all the prerequisites of Hyperledger Fabric.**

---

## Step by Step Guide

Follow the step by step guide to start the network and set up the server

#### CA-NETWORK

cd ca-network

Go to the ca-network directory and follow the commands:

```sh
sudo ./clean.sh
```

This command will clean all the containers which is exited.

```sh
docker-compose -f docker-compose-ca.yaml up -d
```

This command will start the Certificate Authority containers

```sh
./network.sh
```

This command will start generating the certificates of the above mentioned organizations.

###############################################################################################

#### FABRIC-NETWORK

```sh
cd ../network
```

Go to the network directory and follow the commands:

# ```sh

# sudo ./clean.sh

# ```

if [ -d "channel-artifacts" ]; then
rm -Rf channel-artifacts && rm -Rf crypto-config
fi

This command will clean any existing artifacts.

```sh
mkdir channel-artifacts && mkdir crypto-config
```

This command will create the channel-artifcats and crypto-config directory.

```sh
cp -rvf ../ca-network/organizations/fabric-ca ./crypto-config
```

This command will copy fabric-ca directory from ca-network to crypto-config directory.

```sh
cp -rvf ../ca-network/organizations/ordererOrganizations ./crypto-config
```

This command will copy ordererOrganizations directory from ca-network to crypto-config directory.

```sh
cp -rvf ../ca-network/organizations/peerOrganizations ./crypto-config
```

This command will copy peerOrganizations directory from ca-network to crypto-config directory.

```sh
./artifact.sh
```

This command will generate all the channel related artifacts for the Fabric Network.

```sh
docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml -f docker-compose-couchdb.yaml up -d
```

# If not workign try docker-compose -f docker-compose-basic-cli.yaml up -d

This command will start all the peers, orderers and cli containers for the network.

```sh
docker exec -it cli bash
```

This command will open the cli for executing the peers command

Once you are in the container you will be able to see the output like this

```sh
bash-5.1#
```

Now, following are the commands which needs to be executed from the cli

```sh
./scripts/channel.sh
```

This command with create the channel and join all Orgs.

```sh
./scripts/chaincode.sh
```

This command with package and install chaincode on all peers.

################################################################################
