package controller

import (
	"encoding/json"
	"fmt"

	messages "CHAINCODE-REST/products/core/messages"

	product "CHAINCODE-REST/products/schema"
	state "CHAINCODE-REST/products/util"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// AddProduct issues a new product to the world state with given details.
func AddProduct(ctx contractapi.TransactionContextInterface, name string, description string, quantity int, origin string, price int) error {
	exists, err := state.ProductExists(ctx, name)
	if err != nil {
		return err
	}
	if exists {
		return fmt.Errorf(messages.ProductAlreadyExists, name)
	}

	newProduct := product.Product{
		Name:            name,
		Description:     description,
		Quantity:        quantity,
		Origin:          origin,
		Price:           price,
	}
	assetJSON, err := json.Marshal(newProduct)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(name, assetJSON)
}

// ViewProduct returns the product stored in the world state with given name.
func ViewProduct(ctx contractapi.TransactionContextInterface, name string) (*product.Product, error) {
	productJSON, err := ctx.GetStub().GetState(name)
	if err != nil {
		return nil, fmt.Errorf(messages.FailedToRead, err)
	}
	if productJSON == nil {
		return nil, fmt.Errorf(messages.ProductDoesnotExist, name)
	}

	var existingProduct product.Product
	err = json.Unmarshal(productJSON, &existingProduct)
	if err != nil {
		return nil, err
	}

	return &existingProduct, nil
}

// ViewAllProducts returns all products found in world state
func ViewAllProducts(ctx contractapi.TransactionContextInterface) ([]*product.Product, error) {
	// range query with empty string for startKey and endKey does an
	// open-ended query of all assets in the chaincode namespace.
	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	if resultsIterator == nil {
		return nil, fmt.Errorf (messages.EmptyState)
	}
	defer resultsIterator.Close()

	var products []*product.Product
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}

		var existingProduct product.Product
		err = json.Unmarshal(queryResponse.Value, &existingProduct)
		if err != nil {
			return nil, err
		}
		products = append(products, &existingProduct)
	}

	return products, nil
}


// UpdateProduct updates an existing product in the world state with provided parameters.
func UpdateProduct(ctx contractapi.TransactionContextInterface, name string, description string, quantity int, origin string, price int) error {
	exists, err := state.ProductExists(ctx, name)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf(messages.ProductDoesnotExist, name)
	}

	// overwriting original asset with new asset
	product := product.Product{
		Name:            name,
		Description:     description,
		Quantity:        quantity,
		Origin:          origin,
		Price:           price,
	}
	productJSON, err := json.Marshal(product)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(name, productJSON)
}

// DeleteProduct deletes an given product from the world state.
func DeleteProduct(ctx contractapi.TransactionContextInterface, name string) error {
	exists, err := state.ProductExists(ctx, name)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf(messages.ProductDoesnotExist, name)
	}

	return ctx.GetStub().DelState(name)
}

// DeleteAllProducts deletes all products from the world state.
func DeleteAllProducts(ctx contractapi.TransactionContextInterface) error {

	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return  err
	}
	defer resultsIterator.Close()

	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return  err
		}

		var existingProduct product.Product
		err = json.Unmarshal(queryResponse.Value, &existingProduct)
		if err != nil {
			return  err
		}

		errStub := ctx.GetStub().DelState(queryResponse.Key)
		if errStub != nil {
			return  errStub
		}
	}
	return err
}


// ProductExists returns true when product with given name exists in world state
func ProductExists(ctx contractapi.TransactionContextInterface, name string) (bool, error) {
	assetJSON, err := ctx.GetStub().GetState(name)
	if err != nil {
		return false, fmt.Errorf(messages.FailedToRead, err)
	}

	return assetJSON != nil, nil
}

// TransferProduct updates the origin field of product with given name in world state.
func TransferProduct(ctx contractapi.TransactionContextInterface, name string, newOrigin string) error {
	product, err := ViewProduct(ctx, name)
	if err != nil {
		return err
	}

	product.Origin = newOrigin
	productJSON, err := json.Marshal(product)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(name, productJSON)
}


