const mongoose = require("mongoose");
const ObjectId = mongoose.Types.ObjectId;
const Schema = mongoose.Schema;

const userSchema = new Schema({
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    name: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    phone: {
        type: String,
        required: true,
    },
    favourite: [
        {
            _id: {
                type: Schema.Types.ObjectId,
                ref: "Product",
            },
        },
    ],
});

const User = mongoose.model("User", userSchema);

module.exports.User = User;

exports.viewProfile = async (id) => {
    try {
        console.log(id);
        const result = await User.aggregate([
            {
                $match: { _id: new ObjectId(id) },
            },
            {
                $lookup: {
                    from: "products",
                    localField: "_id",
                    foreignField: "user_id",
                    as: "product-logs",
                },
            },
        ]);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};