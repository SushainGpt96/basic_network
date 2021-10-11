const products = require('../services/products')
const responseHandler =  require('../middleware/responseHandler')

module.exports = {
    registerAdmin : async (req, res)=> {
        console.log("Inside Register Admin Controller")
        try {
            let register = await products.registerAdmin()
            return responseHandler.sendResponse(res,200,register)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    registerUser : async (req,res)=> {
        console.log("Inside Register User Controller")
        try {
            let username = req.body.username

            let register = await products.registerUser(username)
            return responseHandler.sendResponse(res,200,register)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    addProduct : async (req,res)=> {
        console.log("Inside addProduct controller")
        try {
            let username = req.body.username

            let arguments = [req.body.name, req.body.description,req.body.quantity,req.body.origin,req.body.price]
            
            let addProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'AddProduct', arguments)
            let msg = "Product added by "+username+" Product  "+req.body.name +addProduct
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    viewProduct : async (req,res)=> {
        console.log("Inside viewProduct Controller")
        try {
            let username = req.body.username
            let arguments = [req.body.name]

            let viewProduct = await products.queryChaincode(username, 'productchannel', 'products', 'ViewProduct', arguments)
            return responseHandler.sendResponse(res,200,viewProduct)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    viewAllProducts : async (req,res)=> {
        console.log("Inside viewAllProduct Controller")
        try {
            let username = req.body.username
            let arguments = []

            let viewAllProducts = await products.queryChaincode(username, 'productchannel', 'products', 'ViewAllProducts', arguments)
            return responseHandler.sendResponse(res,200,viewAllProducts)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    updateProduct : async (req,res)=> {
        console.log("Inside updateProduct controller")
        try {
            let username = req.body.username

            let arguments = [req.body.name, req.body.description,req.body.quantity,req.body.origin,req.body.price]
            
            let updateProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'UpdateProduct', arguments)
            let msg = "Product updated by "+username+" Product  "+req.body.name +updateProduct
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    deleteProduct : async (req,res)=> {
        console.log("Inside deleteProduct Controller")
        try {
            let username = req.body.username
            let arguments = [req.body.name]

            let deleteProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'DeleteProduct', arguments)
            let msg = "Product"+ arguments+" has been deleted "+deleteProduct
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    deleteAllProducts : async (req,res)=> {
        console.log("Inside deleteAllProducts Controller")
        try {
            let username = req.body.username
            let arguments = []
            let deleteAllProducts = await products.invokeChaincode(username, 'productchannel', 'products', 'DeleteAllProductss', arguments)
            let msg = "Product"+ name+" has been deleted "+deleteAllProducts
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    transferProduct : async (req,res)=> {
        console.log("Inside Transfer Product Controller")
        try {
            let username =  req.body.username
            let arguments = [req.body.name, req.body.newOrigin]
            console.log("arguments", arguments)

            let transferProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'TransferProduct', arguments)
            let msg = "Product "+ req.body.name +" has been to transfered to: "+ req.body.newOrigin +transferFunds
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },

}