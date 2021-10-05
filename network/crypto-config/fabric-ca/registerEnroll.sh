function createcity1 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/city1.product.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/city1.product.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-city1 --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-city1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-city1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-city1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-city1.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/city1.product.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-city1 --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  echo
	echo "Register peer1"
  echo
  set -x
	fabric-ca-client register --caname ca-city1 --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-city1 --id.name user1 --id.secret user1pw --id.type client --id.attrs '"hf.Registrar.Roles=client"' --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-city1 --id.name city1admin --id.secret city1adminpw --id.type admin --id.attrs '"hf.Registrar.Roles=admin"' --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

	mkdir -p organizations/peerOrganizations/city1.product.com/peers
  mkdir -p organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com
  mkdir -p organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/msp --csr.hosts peer0.city1.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city1.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/msp/config.yaml

  echo
  echo "## Generate the peer1 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/msp --csr.hosts peer1.city1.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city1.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls --enrollment.profile tls --csr.hosts peer0.city1.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/city1.product.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/city1.product.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/tlsca/tlsca.product.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/city1.product.com/ca
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer0.city1.product.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/ca/ca.product.com-cert.pem

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls --enrollment.profile tls --csr.hosts peer1.city1.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city1.product.com/peers/peer1.city1.product.com/tls/server.key

  mkdir -p organizations/peerOrganizations/city1.product.com/users
  mkdir -p organizations/peerOrganizations/city1.product.com/users/User1@city1.product.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/users/User1@city1.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  mkdir -p organizations/peerOrganizations/city1.product.com/users/Admin@city1.product.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://city1admin:city1adminpw@localhost:7054 --caname ca-city1 -M ${PWD}/organizations/peerOrganizations/city1.product.com/users/Admin@city1.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city1/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city1.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city1.product.com/users/Admin@city1.product.com/msp/config.yaml

}

function createcity2 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/city2.product.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/city2.product.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-city2 --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-city2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-city2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-city2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-city2.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/city2.product.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-city2 --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  echo
	echo "Register peer1"
  echo
  set -x
	fabric-ca-client register --caname ca-city2 --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-city2 --id.name user1 --id.secret user1pw --id.type client --id.attrs '"hf.Registrar.Roles=client"' --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-city2 --id.name city2admin --id.secret city2adminpw --id.type admin --id.attrs '"hf.Registrar.Roles=admin"' --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

	mkdir -p organizations/peerOrganizations/city2.product.com/peers
  mkdir -p organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com
  mkdir -p organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/msp --csr.hosts peer0.city2.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city2.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/msp/config.yaml

  echo
  echo "## Generate the peer1 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/msp --csr.hosts peer1.city2.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city2.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls --enrollment.profile tls --csr.hosts peer0.city2.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/city2.product.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/city2.product.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/tlsca/tlsca.product.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/city2.product.com/ca
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer0.city2.product.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/ca/ca.product.com-cert.pem

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls --enrollment.profile tls --csr.hosts peer1.city2.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city2.product.com/peers/peer1.city2.product.com/tls/server.key

  mkdir -p organizations/peerOrganizations/city2.product.com/users
  mkdir -p organizations/peerOrganizations/city2.product.com/users/User1@city2.product.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/users/User1@city2.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  mkdir -p organizations/peerOrganizations/city2.product.com/users/Admin@city2.product.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://city2admin:city2adminpw@localhost:8054 --caname ca-city2 -M ${PWD}/organizations/peerOrganizations/city2.product.com/users/Admin@city2.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city2/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city2.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city2.product.com/users/Admin@city2.product.com/msp/config.yaml

}


function createcity3 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/city3.product.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/city3.product.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca-city3 --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-city3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-city3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-city3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-city3.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/city3.product.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-city3 --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  echo
	echo "Register peer1"
  echo
  set -x
	fabric-ca-client register --caname ca-city3 --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-city3 --id.name user1 --id.secret user1pw --id.type client --id.attrs '"hf.Registrar.Roles=client"' --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-city3 --id.name city3admin --id.secret city3adminpw --id.type admin --id.attrs '"hf.Registrar.Roles=admin"' --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

	mkdir -p organizations/peerOrganizations/city3.product.com/peers
  mkdir -p organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com
  mkdir -p organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/msp --csr.hosts peer0.city3.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city3.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/msp/config.yaml

  echo
  echo "## Generate the peer1 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/msp --csr.hosts peer1.city3.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city3.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls --enrollment.profile tls --csr.hosts peer0.city3.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/city3.product.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/city3.product.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/tlsca/tlsca.product.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/city3.product.com/ca
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer0.city3.product.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/ca/ca.product.com-cert.pem

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls --enrollment.profile tls --csr.hosts peer1.city3.product.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/city3.product.com/peers/peer1.city3.product.com/tls/server.key

  mkdir -p organizations/peerOrganizations/city3.product.com/users
  mkdir -p organizations/peerOrganizations/city3.product.com/users/User1@city3.product.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/users/User1@city3.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  mkdir -p organizations/peerOrganizations/city3.product.com/users/Admin@city3.product.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://city3admin:city3adminpw@localhost:10054 --caname ca-city3 -M ${PWD}/organizations/peerOrganizations/city3.product.com/users/Admin@city3.product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/city3/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/city3.product.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/city3.product.com/users/Admin@city3.product.com/msp/config.yaml

}

function createOrderer {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/ordererOrganizations/product.com

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/product.com
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml


  echo
	echo "Register orderer"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo
	echo "Register ordere2"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret orderer2pw --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo
	echo "Register orderer3"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret orderer3pw --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo
	echo "Register orderer4"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer4 --id.secret orderer4pw --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo
	echo "Register orderer5"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer5 --id.secret orderer5pw --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo
  echo "Register the orderer admin"
  echo
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --id.attrs '"hf.Registrar.Roles=admin"' --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

	mkdir -p organizations/ordererOrganizations/product.com/orderers
  ##to be checked

  mkdir -p organizations/ordererOrganizations/product.com/orderers/product.com

  mkdir -p organizations/ordererOrganizations/product.com/orderers/orderer.product.com
  mkdir -p organizations/ordererOrganizations/product.com/orderers/orderer2.product.com
  mkdir -p organizations/ordererOrganizations/product.com/orderers/orderer3.product.com
  mkdir -p organizations/ordererOrganizations/product.com/orderers/orderer4.product.com
  mkdir -p organizations/ordererOrganizations/product.com/orderers/orderer5.product.com

  echo
  echo "## Generate the orderer msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/msp --csr.hosts orderer.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/msp/config.yaml

  echo
  echo "## Generate the orderer2 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/msp --csr.hosts orderer2.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/msp/config.yaml

  echo
  echo "## Generate the orderer3 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/msp --csr.hosts orderer3.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/msp/config.yaml

  echo
  echo "## Generate the orderer4 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/msp --csr.hosts orderer4.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/msp/config.yaml

  echo
  echo "## Generate the orderer5 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/msp --csr.hosts orderer5.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls --enrollment.profile tls --csr.hosts orderer.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/server.key

  mkdir ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/msp/tlscacerts/tlsca.product.com-cert.pem

  mkdir ${PWD}/organizations/ordererOrganizations/product.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/msp/tlscacerts/tlsca.product.com-cert.pem

  echo
  echo "## Generate the orderer2-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls --enrollment.profile tls --csr.hosts orderer2.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer2.product.com/tls/server.key

  echo
  echo "## Generate the orderer3-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls --enrollment.profile tls --csr.hosts orderer3.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer3.product.com/tls/server.key

  echo
  echo "## Generate the orderer4-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls --enrollment.profile tls --csr.hosts orderer4.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer4.product.com/tls/server.key

  echo
  echo "## Generate the orderer5-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls --enrollment.profile tls --csr.hosts orderer5.product.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/product.com/orderers/orderer5.product.com/tls/server.key

  mkdir -p organizations/ordererOrganizations/product.com/users
  mkdir -p organizations/ordererOrganizations/product.com/users/Admin@city1.product.com

  echo
  echo "## Generate the admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/product.com/users/Admin@product.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/product.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/product.com/users/Admin@product.com/msp/config.yaml

}
# createcity1
# createcity2
# createcity3
# createOrderer
