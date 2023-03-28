const db = require("../model/auth");
const crypto = require("crypto-js");
const jwt = require("jsonwebtoken");
const errors = require("../util/error_handling");
const { validateUserData, validateLogIn } = require("../util/validation");
require("dotenv").config();

exports.signup = async (req, res, next) => {
    try {
        const { name, email, password, address, phone } = req.body;
        const { error } = validateUserData(req.body);
        if (error) {
            console.log(error);
            errors.validationError(error.details);
        }
        const emailExist = await db.emailExist(email);
        if (emailExist){
            errors.validationError("this email isn't available");
        }
        hashedPassword = crypto.AES.encrypt(
            password,
            process.env.PASSWORD_SECRET
        );
        result = await db.signup(name, email, hashedPassword, address, phone);
        if (result) {
            return res.status(201).json({ result: "user created succesfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.login = async (req, res, next) => {
    try {
        const { email, password: inputPassword } = req.body;
        const { error } = validateLogIn(req.body);
        if (error) {
            errors.validationError(error.details);
        }
        const user = await db.login(email);
        if (!user) {
            errors.unauthorizedError("wrong email or password");
        }
        userPassword = crypto.AES.decrypt(
            user.password,
            process.env.PASSWORD_SECRET
        ).toString(crypto.enc.Utf8);
        if (inputPassword !== userPassword) {
            errors.unauthorizedError("wrong email or password");
        }
        const accessToken = jwt.sign(
            {
                id: user._id,
                isAdmin: (user.admin ? user.admin  : false) ,
            },
            process.env.JWT_SECRET,
            { expiresIn: "3d" }
        );
        const { password, ...other } = user;
        res.status(200).json({ userData: { ...other, accessToken } });
    } catch (err) {
        console.log(err);
        next(err);
    }
};
