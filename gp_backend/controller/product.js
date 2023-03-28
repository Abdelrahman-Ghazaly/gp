const db = require("../model/product");
const errors = require("../util/error_handling");
const { validateProductData } = require("../util/validation");

exports.createProduct = async (req, res, next) => {
    try {
        const productData = req.body;
        const { error } = validateProductData(productData);
        if (error) {
            errors.validationError(error.details);
        }
        const result = await db.createProduct(productData, req.user.id);
        if (result) {
            res.status(201).json({ message: "product created Successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.deleteProduct = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const result = await db.deleteProduct(productId, req.user.id);
        if (result) {
            res.status(200).json({ message: "product deleted Successfully" });
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
            res.status(200).json(result[0]);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.viewOneProduct = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const result = await db.viewOneProduct(productId);
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
