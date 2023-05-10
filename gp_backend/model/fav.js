const { User } = require("./user");

exports.addProductToFav = async (userId, productId) => {
    try {
        const result = await User.findByIdAndUpdate(
            { _id: userId },
            { $push: { favourite: { _id: productId } } },
            { new: true }
        ).populate("favourite._id");
        return result.favourite.at(-1);
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
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.getFav = async (userId) => {
    try {
        const result = await User.findById(userId).populate("favourite._id");
        return result.favourite;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.removeDeletedProduct = async (product_id) => {
    try {
        const result = await User.updateMany(
            { favourite: { _id: product_id } },
            { $pull: { favourite: { _id: product_id } } }
        );
        return result.favourite;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};
;