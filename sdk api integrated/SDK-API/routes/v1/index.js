const express = require('express')
const router = express.Router()

const city1 = require('./city1')
const city2 = require('./city2')
const city3 = require('./city3')

router.use('/city1', city1)
router.use('/city2', city2)
router.use('/city3', city3)

module.exports = router;