const db = require("../model/product");
const reportDb = require("../model/report");
const favDb = require("../model/fav");
const { validateProductData } = require("../util/validation");
const { deleteProductImages } = require("../util/images_processes");
const errors = require("../util/error_handling");

exports.productValidation = async (req, res, next) => {
    try {
        const productData = req.body;
        const { error } = validateProductData(productData);
        if (error) {
            errors.validationError(error);
        }
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.createProduct = async (req, res, next) => {
    try {
        const productData = req.body;
        const result = await db.createProduct(
            productData,
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

exports.deleteProduct = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const productResult = await db.deleteProduct(productId, req.user.id);
        productResult && (await reportDb.deleteProductReports(productId));
        productResult && (await favDb.removeDeletedProduct(productId));
        productResult && (await deleteProductImages(productResult.imgURL));
        if (productResult) {
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

exports.getUserProducts = async (req, res, next) => {
    try {
        const userId = req.user.id;
        const result = await db.getUserProducts(userId);
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
