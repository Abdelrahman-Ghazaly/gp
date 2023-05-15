const db = require("../model/conversation");
const errors = require("../util/error_handling");

exports.createMessage = async (req, res, next) => {
    try {
        const { conversationId, sender, text } = req.body;
        const result = await db.createMessage(conversationId, sender, text);
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

exports.getMessages= async (req, res, next) => {
    try {
        const result = await db.getMessages(req.params.conversationId);
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
