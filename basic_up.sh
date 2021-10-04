cd ca-network
./clean.sh
./network.sh
cd ../network
mkdir channel-artifacts && mkdir crypto-config
cp -rvf ../ca-network/organizations/fabric-ca ./crypto-config
cp -rvf ../ca-network/organizations/ordererOrganizations ./crypto-config
cp -rvf ../ca-network/organizations/peerOrganizations ./crypto-config
./artifact.sh
docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml  up -d
# docker-compose -f docker-compose-basic-cli.yaml -f docker-compose-etcdraft2.yaml  up -d
docker exec -it cli bash
#inside bash
./scripts/channel.sh
./scripts/chaincode.sh
