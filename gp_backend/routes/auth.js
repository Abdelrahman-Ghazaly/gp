const express = require("express");
const router = express.Router();
const auth = require("../middleware/is_auth");
const authConroller = require("../controller/auth");

router.post("/signup",authConroller.signup);

router.post("/login", authConroller.login);

module.exports = router;
