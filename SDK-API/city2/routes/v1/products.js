const productsController = require('../../controller/products')
const express = require('express')
const router = express.Router()

router.post('/city2/registerAdmin',productsController.registerAdmin)
router.post('/city2/registerUser',productsController.registerUser)
router.post('/city2/addProduct',productsController.addProduct)
router.post('/city2/viewProduct',productsController.viewProduct)
router.post('/city2/viewAllProducts',productsController.viewAllProducts)
router.post('/city2/updateProduct',productsController.updateProduct)
router.post('/city2/deleteProduct',productsController.deleteProduct)
router.post('/city2/deleteAllProduct',productsController.deleteAllProducts)
router.post('/city2/transferProduct',productsController.transferProduct)

module.exports = router