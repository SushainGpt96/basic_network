const productsController = require('../../controller/products')
const express = require('express')
const router = express.Router()

router.post('/city1/registerAdmin',productsController.registerAdmin)
router.post('/city1/registerUser',productsController.registerUser)
router.post('/city1/addProduct',productsController.addProduct)
router.post('/city1/viewProduct',productsController.viewProduct)
router.post('/city1/viewAllProducts',productsController.viewAllProducts)
router.post('/city1/updateProduct',productsController.updateProduct)
router.post('/city1/deleteProduct',productsController.deleteProduct)
router.post('/city1/deleteAllProduct',productsController.deleteAllProducts)
router.post('/city1/transferProduct',productsController.transferProduct)

module.exports = router