const db = require("../model/report");
const productDb = require("../model/product");
const favDb = require("../model/fav");
const { deleteProductImages } = require("../util/images_processes");
const errors = require("../util/error_handling");

exports.reportProduct = async (req, res, next) => {
    try {
        const { description, report_type } = req.body;
        const result = await db.reportProduct(
            report_type,
            description,
            req.user.id,
            req.params.productId
        );
        if (result) {
            res.status(201).json({ message: "product reported Successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.viewReports = async (req, res, next) => {
    try {
        const result = await db.viewReports();
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

exports.acceptReport = async (req, res, next) => {
    try {
        const reportResult = await db.acceptReport(req.params.reportId);
        const productResult = reportResult
            ? await productDb.deleteProductByAdmin(reportResult.product_id)
            : false;
        productResult && (await db.deleteProductReports(productId));
        productResult && (await favDb.removeDeletedProduct(productId));
        productResult && (await deleteProductImages(productResult.imgURL));
        if (reportResult) {
            res.status(200).json({ message: "Report Accepted" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};
