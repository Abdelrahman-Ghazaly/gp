const db = require("../model/auction");
const { validateProductData } = require("../util/validation");
const errors = require("../util/error_handling");

exports.createAuction = async (req, res, next) => {
    try {
        const auctionData = req.body;
        //  const { error } = validateAuctionData(auctionData);
        // if (error) {
        //     errors.validationError(error);
        // }
        const result = await db.createAuction(
            auctionData,
            req.user.id,
            req.imageURLs
        );
        if (result) {
            res.status(201).json(result);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};
