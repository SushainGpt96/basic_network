const products = require('../services/products')
const responseHandler =  require('../middleware/responseHandler')


module.exports = {
    registerAdmin : async (req, res)=> {
        console.log("Inside Register Admin Controller")
        try {
            let org = req.body.org
            let register = await products.registerAdmin(org)
            return responseHandler.sendResponse(res,200,register)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    registerUser : async (req,res)=> {
        console.log("Inside Register User Controller")
        try {
            let org = req.body.org
            let username = req.body.username
            // let username = "raj6@product.com"
            if (!username){
                console.log("No username added")
            }
            let register = await products.registerUser(username,org)
            return responseHandler.sendResponse(res,200,register)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    addProduct : async (req,res)=> {
        console.log("Inside addProduct controller")
        try {
            let org = req.body.org
            let username = req.body.username
            let args = [req.body.name, req.body.description,req.body.quantity,req.body.origin,req.body.price]
            
            let addProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'AddProduct', args, org)
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
            let org = req.body.org
            let username = req.body.username
            let args = [req.body.name]

            let viewProduct = await products.queryChaincode(username, 'productchannel', 'products', 'ViewProduct', args, org)
            return responseHandler.sendResponse(res,200,viewProduct)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    viewAllProducts : async (req,res)=> {
        console.log("Inside viewAllProduct Controller")
        try {
            let org = req.body.org
            let username = req.body.username
            // let username = "raj2@product.com"
            let args = []

            let viewAllProducts = await products.queryChaincode(username, 'productchannel', 'products', 'ViewAllProducts', args, org)
            return responseHandler.sendResponse(res,200,viewAllProducts)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    updateProduct : async (req,res)=> {
        console.log("Inside updateProduct controller")
        try {
            let org = req.body.org
            let username = req.body.username

            let args = [req.body.name, req.body.description,req.body.quantity,req.body.origin,req.body.price]
            
            let updateProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'UpdateProduct', args, org)
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
            let org = req.body.org
            let username = req.body.username
            let args = [req.body.name]

            let deleteProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'DeleteProduct', args, org)
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
            let org = req.body.org
            let username = req.body.username
            let args = []
            let deleteAllProducts = await products.invokeChaincode(username, 'productchannel', 'products', 'DeleteAllProductss', args, org)
            let msg = "All products have been deleted "+deleteAllProducts
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    transferProduct : async (req,res)=> {
        console.log("Inside Transfer Product Controller")
        try {
            let org = req.body.org
            let username =  req.body.username
            let args = [req.body.name, req.body.newOrigin]
            console.log("arguments", arguments)

            let transferProduct = await products.invokeChaincode(username, 'productchannel', 'products', 'TransferProduct', args, org)
            let msg = "Product "+ req.body.name +" has been to transfered to: "+ req.body.newOrigin +transferProduct
            return responseHandler.sendResponse(res,200,msg)
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },

}