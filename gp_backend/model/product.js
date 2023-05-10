const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const productSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    imgURL: [
        {
            type: String,
            required: true,
        },
    ],
    category: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    user_id: {
        type: Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
});

const Product = mongoose.model("Product", productSchema);

exports.createProduct = async (productData, user_id, imgURL) => {
    try {
        const { title, description, category, price } = productData;
        const product = new Product({
            title,
            description,
            imgURL,
            category,
            price,
            user_id,
        });
        const result = await product.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.deleteProduct = async (productId, user_id) => {
    try {
        const result = await Product.findOneAndRemove({
            _id: productId,
            user_id: user_id,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.deleteProductByAdmin = async (productId) => {
    try {
        const result = await Product.findOneAndDelete({
            _id: productId,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.getProductImagesForDeletation = async (productId, user_id) => {
    try {
        const result = await Product.find({
            _id: productId,
            user_id: user_id,
        });
        return result[0];
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.view = async () => {
    try {
        const result = await Product.aggregate([
            {
                $group: {
                    _id: "$category",
                    products: { $push: "$$ROOT" },
                },
            },
            {
                $group: {
                    _id: null,
                    products: {
                        $push: {
                            k: "$_id",
                            v: "$products",
                        },
                    },
                },
            },
            {
                $replaceWith: { $arrayToObject: "$products" },
            },
            {
                $project: {
                    chair: { $slice: ["$chair", 6] },
                    bed: { $slice: ["$bed", 6] },
                    lamp: { $slice: ["$lamp", 6] },
                    dresser: { $slice: ["$dresser", 6] },
                    table: { $slice: ["$table", 6] },
                    sofa: { $slice: ["$sofa", 6] },
                },
            },
        ]);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.viewOneProduct = async (productId) => {
    try {
        const result = await Product.findById(productId).populate(
            "user_id",
            "_id name"
        );
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.search = async (query, category, minPrice, maxPrice) => {
    try {
        const filters = {};
        if (query) {
            filters.$or = [
                { title: { $regex: query, $options: "i" } },
                { description: { $regex: query, $options: "i" } },
            ];
        }
        if (category) {
            filters.category = category;
        }
        if (minPrice && maxPrice) {
            filters.price = {};
            filters.price.$gt = parseInt(minPrice) - 1;
            filters.price.$lt = parseInt(maxPrice) + 1;
        } else if (minPrice) {
            filters.price = {};
            filters.price.$gt = parseInt(minPrice) - 1;
        } else if (maxPrice) {
            filters.price = {};
            filters.price.$lt = parseInt(maxPrice) + 1;
        }
        const result = await Product.find(filters);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.getUserProducts = async (userId) => {
    try {
        const result = await Product.find({ user_id: userId });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};