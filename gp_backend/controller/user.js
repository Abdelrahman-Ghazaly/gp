const db = require("../model/user");
const crypto = require("crypto-js");
const errors = require("../util/error_handling");
const { validateUserData } = require("../util/validation");

exports.viewProfile = async (req, res, next) => {
    try {
        const userId = req.params.userId;
        const result = await db.viewProfile(userId);
        if (result) {
            res.status(200).json({"user-data":result[0]});
        } else {
            errors.notFoundError();
            
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

