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

exports.deleteAuction = async (req, res, next) => {
    try {
        const auctionId = req.params.auctionId;
        const result = await db.deleteAuction(auctionId, req.user.id);
        if (result) {
            res.status(200).json({ message: "auction deleted successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.view = async (req, res, next) => {
    try {
        const result = await db.view();
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

exports.viewOneAuction = async (req, res, next) => {
    try {
        const auctionId = req.params.auctionId;
        const result = await db.viewOneAuction(auctionId);
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

exports.search = async (req, res, next) => {
    try {
        const query = req.query.query;
        const minPrice = req.query.minPrice;
        const maxPrice = req.query.maxPrice;
        const category = req.query.category;
        const result = await db.search(query, category, minPrice, maxPrice);
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