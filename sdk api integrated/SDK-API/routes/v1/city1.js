const productsController = require("../../controller/products");
const express = require("express");
const router = express.Router();

router.post("/registerAdmin", productsController.registerAdmin);
router.post("/registerUser", productsController.registerUser);
router.post("/addProduct", productsController.addProduct);
router.post("/viewProduct", productsController.viewProduct);
router.post("/viewAllProducts", productsController.viewAllProducts);
router.post("/updateProduct", productsController.updateProduct);
router.post("/deleteProduct", productsController.deleteProduct);
router.post("/deleteAllProducts", productsController.deleteAllProducts);
router.post("/transferProduct", productsController.transferProduct);

module.exports = router;
