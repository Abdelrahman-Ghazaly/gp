const express = require("express");
const auth = require("../middleware/is_auth");
const auctionController = require("../controller/auction");
const images = require("../util/images_processes");
const router = express.Router();


router.post(
    "/upload",
    auth.verifyLogedin,
    images.uploadImage,
    images.uploadToFirebase,
    auctionController.createAuction
);



module.exports = router;