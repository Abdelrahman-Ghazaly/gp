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

router.delete(
    "/delete/:auctionId",
    auth.verifyLogedin,
    auctionController.deleteAuction
);

router.get("/view", auctionController.view);

router.get(
    "/view/item/:auctionId",
    auctionController.viewOneAuction
);

router.get("/search/auction", auctionController.search);

router.put(
    "/bid/:auctionId",
    auth.verifyLogedin,
    auctionController.bidAuction
);

router.get("/view/requests", auth.verifyAdmin, auctionController.viewAuctionRequests);

router.put(
    "/accept/:auctionId",
    auth.verifyAdmin,
    auctionController.acceptAuctionRequest
);

router.delete(
    "/refuse/:auctionId",
    auth.verifyAdmin,
    auctionController.refuseAuctionRequest
);

module.exports = router;