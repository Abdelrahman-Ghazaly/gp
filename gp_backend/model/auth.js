const {User} = require("./user");



exports.emailExist = async (email) => {
    try {
        result = await User.find({email : email})
        return result[0];
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.signup = async (name, email, password, address, phone) => {
    try {
        const user = new User({ name, email, password, address, phone });
        const result = await user.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.login = async (email) => {
    try {
        result = await User.find({email : email})
        return result[0]._doc;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};