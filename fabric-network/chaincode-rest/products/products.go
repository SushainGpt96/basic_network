package main

import (
	"fmt"

	messages "CHAINCODE-REST/products/core/messages"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract provides functions for managing an Asset
type SmartContract struct {
	contractapi.Contract
}

func main() {

	chaincode, err := contractapi.NewChaincode(&SmartContract{})

	if err != nil {
		fmt.Printf(messages.ChaincodeCreateError, err.Error())
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf(messages.ChaincodeStartError, err.Error())
	}
}
