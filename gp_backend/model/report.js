const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const ObjectId = mongoose.Types.ObjectId;

const reportSchema = new Schema({
    report_type: {
        type: String,
        values: ["wrong Category", "offensive title or description"],
        required: true,
    },
    description: {
        type: String,
    },
    user_id: {
        type: Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    product_id: {
        type: Schema.Types.ObjectId,
        ref: "Product",
        required: true,
    },
});

reportSchema.post("validate", function (doc, next) {
    if (
        doc.report_type == "wrong Category" ||
        doc.report_type == "offensive title or description"
    ) {
        next();
    }
    next(new Error("wrong type"));
});

const Report = mongoose.model("Report", reportSchema);

exports.reportProduct = async (
    report_type,
    description,
    user_id,
    product_id
) => {
    try {
        const report = new Report({
            report_type,
            description,
            user_id,
            product_id,
        });
        const result = await report.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.deleteProductReports = async (product_id) => {
    try {
        const result = await Report.deleteMany({ product_id: product_id });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.viewReports = async () => {
    try {
        const result = await Report.find().populate("product_id");
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.acceptReport = async (reportId) => {
    try {
        const result = await Report.findOneAndDelete({
            _id: reportId,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.refuseReport = async (reportId) => {
    try {
        const result = await Report.findOneAndDelete({
            _id: reportId,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};