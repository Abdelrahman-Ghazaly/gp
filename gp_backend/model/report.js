const mongoose = require("mongoose");
const Schema = mongoose.Schema;

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
    console.log(doc);
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
