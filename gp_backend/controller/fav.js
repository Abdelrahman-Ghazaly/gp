const db = require("../model/fav");
const errors = require("../util/error_handling");

exports.addProductToFav = async (req, res, next) => {
    try {
        const {productId} = req.params;
        const result = await db.addProductToFav(req.user.id, productId);
        if (result) {
            res.status(200).json(result._id);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.removeProductFromFav = async (req, res, next) => {
    try {
        const { productId } = req.params;
        const result = await db.removeProductFromFav(req.user.id, productId);
        if (result) {
            res.status(200).json({
                message: "product removed from favourite Successfully",
            });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};


exports.getFav = async (req, res, next) => {
    try {
        const result = await db.getFav(req.user.id);
        if (result) {
            let response = []
            result.forEach(ele => {
                response.push(ele._id);
            })
            res.status(200).json(response);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};