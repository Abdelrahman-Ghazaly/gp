const mongoose = require("mongoose");
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
            type: Schema.Types.ObjectId,
            ref: "Product",
        },
    ],
});

const User = mongoose.model("User", userSchema);


module.exports.User = User;


exports.viewProfile = async (id) => {
    try {
        const result = await User.find({_id: id})
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};
