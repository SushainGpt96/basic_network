echo
echo "##########################################################"
echo "##Install, approve and check commit readiness for City1 ##"
echo "##########################################################"

peer lifecycle chaincode package products.tar.gz --path /opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/products --lang golang --label basic_1.0

#Globals for City 1
export CORE_PEER_LOCALMSPID=city1MSP
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city1.product.com/users/Admin@city1.product.com/msp
export CORE_PEER_ADDRESS=peer0.city1.product.com:7051
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem
 
# Installing chaincode
peer lifecycle chaincode install products.tar.gz

export CCID=$(peer lifecycle chaincode queryinstalled | cut -d ' ' -f 3 | sed s/.$// | grep basic_1.0)

peer lifecycle chaincode approveformyorg --package-id $CCID --channelID productchannel --name products --version 1 --sequence 1 --waitForEvent --tls --cafile $ORDERER_CA
peer lifecycle chaincode checkcommitreadiness --channelID productchannel --name products --version 1  --sequence 1 --tls --cafile $ORDERER_CA

echo
echo "##########################################################"
echo "##Install, approve and check commit readiness for City2 ##"
echo "##########################################################"

#Globals for City 2
export CORE_PEER_LOCALMSPID=city2MSP
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city2.product.com/users/Admin@city2.product.com/msp
export CORE_PEER_ADDRESS=peer0.city2.product.com:9051
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

# Installing chaincode

peer lifecycle chaincode install products.tar.gz
export CCID=$(peer lifecycle chaincode queryinstalled | cut -d ' ' -f 3 | sed s/.$// | grep basic_1.0)

peer lifecycle chaincode approveformyorg --package-id $CCID --channelID productchannel --name products --version 1 --sequence 1 --waitForEvent --tls --cafile $ORDERER_CA
peer lifecycle chaincode checkcommitreadiness --channelID productchannel --name products --version 1  --sequence 1 --tls --cafile $ORDERER_CA

echo
echo "##########################################################"
echo "##Install, approve and check commit readiness for City3 ##"
echo "##########################################################"


#Globals for City 3
export CORE_PEER_LOCALMSPID=city3MSP
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city3.product.com/users/Admin@city3.product.com/msp
export CORE_PEER_ADDRESS=peer0.city3.product.com:11051
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

# Installing chaincode

peer lifecycle chaincode install products.tar.gz
export CCID=$(peer lifecycle chaincode queryinstalled | cut -d ' ' -f 3 | sed s/.$// | grep basic_1.0)

peer lifecycle chaincode approveformyorg --package-id $CCID --channelID productchannel --name products --version 1 --sequence 1 --waitForEvent --tls --cafile $ORDERER_CA
peer lifecycle chaincode checkcommitreadiness --channelID productchannel --name products --version 1  --sequence 1 --tls --cafile $ORDERER_CA

echo
echo "##########################################################"
echo "##################   Commiting Chaincode  ################"
echo "##########################################################"


#Globals for City 1

export CORE_PEER_LOCALMSPID=city1MSP
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/city1.product.com/users/Admin@city1.product.com/msp
export CORE_PEER_ADDRESS=peer0.city1.product.com:7051
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

#Commiting the chaincode

peer lifecycle chaincode commit -o orderer.product.com:7050 --channelID productchannel --name products --version 1 --sequence 1 --tls true --cafile $ORDERER_CA --peerAddresses peer0.city1.product.com:7051 --peerAddresses peer0.city2.product.com:9051 --peerAddresses peer0.city3.product.com:11051  --tlsRootCertFiles ./crypto/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/ca.crt --tlsRootCertFiles ./crypto/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/ca.crt --tlsRootCertFiles ./crypto/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/ca.crt 
