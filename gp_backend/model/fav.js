const { User } = require("./user");

exports.addProductToFav = async (userId, productId) => {
    try {
        const user = await User.findById(userId);
        user.favourite.push(productId);
        const result = await user.save();
        console.log(result);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.removeProductFromFav = async (userId, productId) => {
    try {
        const result = await User.updateOne(
            { _id: userId },
            {
                $pullAll: {
                    favourite: [{ _id: productId }],
                },
            }
        );
        console.log(result);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};
