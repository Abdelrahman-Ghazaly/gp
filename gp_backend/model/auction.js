const mongoose = require("mongoose");
const moment = require("moment");
const Schema = mongoose.Schema;

const auctionSchema = new Schema({
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
    current_pid: {
        type: Number,
        default: 0,
        required: true,
    },
    start_price: {
        type: Number,
        required: true,
    },
    start_date: {
        type: Date,
    },
    end_date: {
        type: Date,
    },
    is_accepted: {
        type: Boolean,
        default: true,
        required: true,
    },
    owner_id: {
        type: Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    winner_id: {
        type: Schema.Types.ObjectId,
        ref: "User",
        default: null,
    },
});

const Auction = mongoose.model("Auction", auctionSchema);

exports.createAuction = async (auctionData, user_id, imgURL) => {
    try {
        const { title, description, category, startPrice, duration } =
            auctionData;
        const currentDate = moment();
        const auction = new Auction({
            title,
            description,
            imgURL,
            category,
            owner_id: user_id,
            start_price: startPrice,
            start_date: currentDate.toISOString(),
            end_date: currentDate.add(duration, "milliseconds").toISOString(),
        });
        const result = await auction.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.deleteAuction = async (auctionId, user_id) => {
    try {
        const result = await Auction.findOneAndRemove({
            _id: auctionId,
            owner_id: user_id,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.view = async () => {
    try {
        const result = await Auction.find({
            end_date: { $gt: new Date() },
            is_accepted: true,
        }).limit(25);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.viewOneAuction = async (auctionId) => {
    try {
        const currentDate = moment().toISOString();
        const result = await Auction.find({
            _id: auctionId,
            end_date: { $gt: currentDate },
        }).populate("owner_id", "_id name");
        return result[0];
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.search = async (query, category, minPrice, maxPrice) => {
    try {
        const filters = {
            end_date: { $gt: new Date() },
        };
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
            filters.current_pid = {};
            filters.current_pid.$gt = parseInt(minPrice) - 1;
            filters.current_pid.$lt = parseInt(maxPrice) + 1;
        } else if (minPrice) {
            filters.current_pid = {};
            filters.current_pid.$gt = parseInt(minPrice) - 1;
        } else if (maxPrice) {
            filters.current_pid = {};
            filters.current_pid.$lt = parseInt(maxPrice) + 1;
        }
        const result = await Auction.find(filters);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};
