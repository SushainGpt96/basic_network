const productsController = require("../../controller/products");
const express = require("express");
const router = express.Router();

router.post("/city3/registerAdmin", productsController.registerAdmin);
router.post("/city3/registerUser", productsController.registerUser);
router.post("/city3/addProduct", productsController.addProduct);
router.post("/city3/viewProduct", productsController.viewProduct);
router.post("/city3/viewAllProducts", productsController.viewAllProducts);
router.post("/city3/updateProduct", productsController.updateProduct);
router.post("/city3/deleteProduct", productsController.deleteProduct);
router.post("/city3/deleteAllProducts", productsController.deleteAllProducts);
router.post("/city3/transferProduct", productsController.transferProduct);

module.exports = router;
