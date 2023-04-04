const express = require("express");
const auth = require("../middleware/is_auth");
const favController = require("../controller/fav");
const router = express.Router();

//add Product to fav
router.post("/add/:productId", auth.verifyLogedin, favController.addProductToFav);


router.delete(
    "/remove/:productId",
    auth.verifyLogedin,
    favController.removeProductFromFav
);

router.get(
    "/get",
    auth.verifyLogedin,
    favController.getFav
);

module.exports = router;
