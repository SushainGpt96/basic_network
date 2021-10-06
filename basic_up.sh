cd ca-network
sudo ./clean.sh
docker-compose -f docker-compose-ca.yaml up -d
./network.sh
cd ../network
if [ -d "channel-artifacts" ]; then
  rm -Rf channel-artifacts && rm -Rf crypto-config
fi
mkdir channel-artifacts && mkdir crypto-config
cp -rvf ../ca-network/organizations/fabric-ca ./crypto-config
cp -rvf ../ca-network/organizations/ordererOrganizations ./crypto-config
cp -rvf ../ca-network/organizations/peerOrganizations ./crypto-config
./artifact.sh
docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml  up -d
docker exec -it cli bash
