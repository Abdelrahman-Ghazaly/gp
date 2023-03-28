const db = require("../model/user");
const crypto = require("crypto-js");
const errors = require("../util/error_handling");
const { validateUserData } = require("../util/validation");

exports.editUser = async (req, res, next) => {
    try {
        const { email, name, password } = req.body;
        const id = req.params.id;
        const { error } = validateUserData(req.body);
        if (error) {
            errors.validationError(error.details);
        }
        const hashedPassword = crypto.AES.encrypt(
            password,
            process.env.PASSWORD_SECRET
        );
        const result = await db.editUser(id, name, email, hashedPassword);
        if (result) {
            res.status(200).json(result);
        } else {
            errors.notFoundError();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};
//comment
