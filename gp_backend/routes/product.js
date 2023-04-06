const express = require("express");
const auth = require("../middleware/is_auth");
const productController = require("../controller/product");
const router = express.Router();

router.post(
    "/upload",
    auth.verifyLogedin,
    productController.uploadImage,
    productController.uploadToFirebase,
    productController.createProduct
);


router.delete(
    "/delete/:productId",
    auth.verifyLogedin,
    productController.deleteProductImages,
    productController.deleteProduct
);

router.get("/view", productController.view);

router.get("/view/item/:productId", productController.viewOneProduct);

router.get("/user/products", auth.verifyLogedin, productController.getUserProducts);

router.get("/search/product", productController.search);



module.exports = router;
