const mongoose = require("mongoose");
const ObjectId = mongoose.Types.ObjectId;
const Schema = mongoose.Schema;
const crypto = require("crypto-js");

const adminSchema = new Schema({
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
});

const Admin = mongoose.model("Admin", adminSchema);

module.exports.Admin = Admin;

exports.login = async (email) => {
    try {
        result = await Admin.find({ email: email });
        return result[0]._doc;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


// exports.signup = async () => {
//     try {
//         const password = "Admin@pass_admin"
//         hashedPassword = crypto.AES.encrypt(
//             password,
//             process.env.PASSWORD_SECRET
//         );
//         const admin = new Admin({
//             name: "Admin",
//             email: "Admin@gmail.com",
//             password: hashedPassword,
//         });
//         const result = await admin.save();
//         console.log(result);
//         return result;
//     } catch (err) {
//         console.log(err);
//         throw new Error();
//     }
// };