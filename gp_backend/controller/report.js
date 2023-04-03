const db = require("../model/report");
const errors = require("../util/error_handling");

exports.reportProduct = async (req, res, next) => {
    try {
        const { description, report_type } = req.body;
        const result = await db.reportProduct(
            report_type,
            description,
            req.user.id,
            req.params.productId,
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
