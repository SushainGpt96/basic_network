const indexRouter = require("./routes/v1/index");
const express = require("express");
const router = express.Router();

router.use("/products", indexRouter);

module.exports = router;
