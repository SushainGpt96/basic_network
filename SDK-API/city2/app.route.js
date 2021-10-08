const products = require('./routes/v1/products')
const express = require('express')
const router = express.Router()

router.use('/products',products)

module.exports = router