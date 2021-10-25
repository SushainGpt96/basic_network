package state

import (
	"fmt"

	messages "CHAINCODE-REST/products/core/messages"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// ProductExists returns true when product with given name exists in world state
func ProductExists(ctx contractapi.TransactionContextInterface, name string) (bool, error) {
	assetJSON, err := ctx.GetStub().GetState(name)
	if err != nil {
		return false, fmt.Errorf(messages.FailedToRead, err)
	}

	return assetJSON != nil, nil
}
