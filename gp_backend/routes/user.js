const express = require("express");
const auth = require("../middleware/is_auth");
const userController = require("../controller/user");
const router = express.Router();

router.get(
    "/view/profile/:userId",
    auth.verifyLogedin,
    userController.viewProfile
);

// router.delete("/:id", auth.verifyAdmin, userController.deleteUser);

// router.get("/find/:id", auth.verifyAdmin, userController.getUser );

// router.get("/", auth.verifyAdmin, userController.getAllUsers);

module.exports = router;
