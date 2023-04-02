const express = require("express");
const auth = require("../middleware/is_auth");
const favController = require("../controller/fav");
const router = express.Router();

//add Product to fav
router.post("/add/:productId", auth.verifyLogedin, favController.addProductToFav);


router.post(
    "/remove/:productId",
    auth.verifyLogedin,
    favController.removeProductFromFav
);


module.exports = router;
