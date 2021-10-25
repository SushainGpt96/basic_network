package main

import (
	controller "CHAINCODE-REST/products/controller"
	product "CHAINCODE-REST/products/schema"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// AddProduct issues a new product to the world state with given details.
func (s *SmartContract) AddProduct(ctx contractapi.TransactionContextInterface, name string, description string, quantity int, origin string, price int) error {
	return controller.AddProduct(ctx , name, description, quantity, origin, price)
}

// ViewProduct returns the product stored in the world state with given name.
func (s *SmartContract) ViewProduct(ctx contractapi.TransactionContextInterface, name string) (*product.Product, error) {
	return controller.ViewProduct(ctx, name)
}

// ViewAllProducts returns all products found in world state
func (s *SmartContract) ViewAllProducts(ctx contractapi.TransactionContextInterface) ([]*product.Product, error) {
	return controller.ViewAllProducts(ctx)
}


// UpdateProduct updates an existing product in the world state with provided parameters.
func (s *SmartContract) UpdateProduct(ctx contractapi.TransactionContextInterface, name string, description string, quantity int, origin string, price int) error {
	return controller.UpdateProduct(ctx , name, description, quantity, origin, price)
}

// DeleteProduct deletes an given product from the world state.
func (s *SmartContract) DeleteProduct(ctx contractapi.TransactionContextInterface, name string) error {
	return controller.DeleteProduct(ctx, name)
}

// DeleteAllProducts deletes all products from the world state.
func (s *SmartContract) DeleteAllProducts(ctx contractapi.TransactionContextInterface) error {
	return controller.DeleteAllProducts(ctx)

}

// TransferProduct updates the origin field of product with given name in world state.
func (s *SmartContract) TransferProduct(ctx contractapi.TransactionContextInterface, name string, newOrigin string) error {
	return controller.TransferProduct(ctx, name, newOrigin)
}







