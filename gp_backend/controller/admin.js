const db = require("../model/admin");
const crypto = require("crypto-js");
const jwt = require("jsonwebtoken");
const errors = require("../util/error_handling");

exports.login = async (req, res, next) => {
    try {
        const { email, password: inputPassword } = req.body;
        const admin = await db.login(email);
        if (!admin) {
            errors.unauthorizedError("wrong email or password");
        }
        adminPassword = crypto.AES.decrypt(
            admin.password,
            process.env.PASSWORD_SECRET
        ).toString(crypto.enc.Utf8);
        if (inputPassword !== adminPassword) {
            errors.unauthorizedError("wrong email or password");
        }
        const accessToken = jwt.sign(
            {
                id: admin._id,
                isAdmin: true,
            },
            process.env.JWT_SECRET,
            { expiresIn: "3d" }
        );
        const { password, ...other } = admin;
        res.status(200).json({ ...other, accessToken });
    } catch (err) {
        console.log(err);
        next(err);
    }
};


// exports.signup = async (req, res, next) => {
//     try {
//         result = await db.signup();
//         if (result) {
//             return res.status(201).json({ result: "admin created succesfully" });
//         } else {
//             throw new Error();
//         }
//     } catch (err) {
//         console.log(err);
//         next(err);
//     }
// };