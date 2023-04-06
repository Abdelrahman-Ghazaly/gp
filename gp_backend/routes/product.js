const express = require("express");
const auth = require("../middleware/is_auth");
const productController = require("../controller/product");
const images = require("../util/images_processes")
const router = express.Router();

router.post(
    "/upload",
    auth.verifyLogedin,
    productController.productValidation,
    images.uploadImage,
    images.uploadToFirebase,
    productController.createProduct
);


router.delete(
    "/delete/:productId",
    auth.verifyLogedin,
    images.deleteProductImages,
    productController.deleteProduct
);

router.get("/view", productController.view);

router.get("/view/item/:productId", productController.viewOneProduct);

router.get("/user/products", auth.verifyLogedin, productController.getUserProducts);

router.get("/search/product", productController.search);



module.exports = router;
