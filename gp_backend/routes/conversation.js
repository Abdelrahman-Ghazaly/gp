const express = require("express");
const router = express.Router();
const auth = require("../middleware/is_auth");
const conversationConroller = require("../controller/conversation");


router.post("/", auth.verifyLogedin, conversationConroller.createConversation);


router.get(
    "/:userId",
    auth.verifyLogedin,
    conversationConroller.getUserConversations
);

module.exports = router;