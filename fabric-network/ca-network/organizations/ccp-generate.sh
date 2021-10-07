#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

ORG=city1
P0PORT=7051
P1PORT=8051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/city1.product.com/tlsca/tlsca.product.com-cert.pem
CAPEM=organizations/peerOrganizations/city1.product.com/ca/ca.product.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/city1.product.com/connection-city1.json

ORG=city2
P0PORT=9051
P1PORT=10051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/city2.product.com/tlsca/tlsca.product.com-cert.pem
CAPEM=organizations/peerOrganizations/city2.product.com/ca/ca.product.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/city2.product.com/connection-city2.json


ORG=city3
P0PORT=11051
P1PORT=12051
CAPORT=10054
PEERPEM=organizations/peerOrganizations/city3.product.com/tlsca/tlsca.product.com-cert.pem
CAPEM=organizations/peerOrganizations/city3.product.com/ca/ca.product.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/city3.product.com/connection-city3.json