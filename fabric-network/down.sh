cd ca-network
docker-compose -f docker-compose-ca.yaml down --volumes --remove-orphans
cd ../network
docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml  down --volumes --remove-orphans

# cd ../ca-network
# sudo ./clean.sh
