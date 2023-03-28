const db = require("../model/fav");
const errors = require("../util/error_handling");



exports.addProductToCart = async (req, res, next) => {
    try {
        const { cartID, productID } = req.body;
        const result = await db.addProductToCart(cartID, productID);
        if (result) {
            res.status(201).json({ message: "product added to cart Successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};


