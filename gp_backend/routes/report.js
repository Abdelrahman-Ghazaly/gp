const express = require("express");
const auth = require("../middleware/is_auth");
const reportController = require("../controller/report");
const router = express.Router();

router.post("/:productId",auth.verifyLogedin ,reportController.reportProduct);



module.exports = router;