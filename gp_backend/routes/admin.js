const express = require("express");
const router = express.Router();
const auth = require("../middleware/is_auth");
const adminConroller = require("../controller/admin");

// router.post("/signup", adminConroller.signup);

router.post("/login", adminConroller.login);

module.exports = router;
