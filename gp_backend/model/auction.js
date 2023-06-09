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
        default: false,
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
    duration: {
        type: Number,
        required: true,
    },
});

const Auction = mongoose.model("Auction", auctionSchema);

exports.createAuction = async (auctionData, user_id, imgURL) => {
    try {
        const { title, description, category, startPrice, duration } =
            auctionData;
            imgURL = [imgURL]
        const auction = new Auction({
            title,
            description,
            imgURL,
            category,
            owner_id: user_id,
            start_price: startPrice,
            current_pid: startPrice,
            duration,
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
        const result = await Auction.find(
            {
                end_date: { $gt: new Date() },
                is_accepted: true,
            },
            { owner_id: 0 }
        ).limit(25);
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
            is_accepted: true,
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
            is_accepted: true,
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
        const result = await Auction.find(filters, { owner_id: 0 });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.bidAuction = async (auctionId, bidAmount, winner_id) => {
    try {
        const currentDate = moment().toISOString();
        const result = await Auction.findOneAndUpdate(
            {
                $and: [
                    { _id: auctionId },
                    { end_date: { $gt: currentDate } },
                    { current_pid: { $lt: parseInt(bidAmount) } },
                    { start_price: { $lt: parseInt(bidAmount) } },
                ],
            },
            {
                current_pid: Number(bidAmount),
                winner_id: winner_id,
            },
            { new: true }
        );
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.viewAuctionRequests = async () => {
    try {
        const result = await Auction.find({
            is_accepted: false,
        });
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};

exports.acceptAuctionRequest = async (auctionId) => {
    try {
        const auction = await Auction.findById(auctionId);
        const currentDate = moment();
        auction.is_accepted = true;
        auction.start_date = currentDate.toISOString();
        auction.end_date = currentDate
            .add(auction.duration, "milliseconds")
            .toISOString();
        const result = await auction.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.refuseAuctionRequest = async (auctionId) => {
    try {
        const result = await Auction.findByIdAndDelete(auctionId);
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};