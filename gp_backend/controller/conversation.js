const db = require("../model/conversation");
const errors = require("../util/error_handling");


exports.createConversation = async (req, res, next) => {
    try {
        const result = await db.createConversation(
            req.body.senderId,
            req.body.receiverId
        );
        if (result) {
            res.status(200).json(result);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};


exports.getUserConversations = async (req, res, next) => {
    try {
        const result = await db.getUserConversations(req.params.userId);
        if (result) {
            res.status(200).json(result);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

