const express = require("express");
const router = express.Router();
const auth = require("../middleware/is_auth");
const messageConroller = require("../controller/message");

router.post("/", auth.verifyLogedin, messageConroller.createMessage);

router.get(
    "/:conversationId",
    auth.verifyLogedin,
    messageConroller.getMessages
);


module.exports = router;