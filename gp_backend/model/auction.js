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
    final_price: {
        type: Number,
        required: true,
    },
    start_date: {
        type: Date,
    },
    end_date: {
        type: Date,
    },
    final_price: {
        type: Number,
        required: true,
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
        default: null
    },
});

const Auction = mongoose.model("Auction", auctionSchema);

exports.createAuction = async (auctionData, user_id, imgURL) => {
    try {
        const {
            title,
            description,
            category,
            finalPrice,
            startPrice,
            duration,
        } = auctionData;
        const currentDate = moment();
        const auction = new Auction({
            title,
            description,
            imgURL,
            category,
            owner_id: user_id,
            start_price: startPrice,
            final_price: finalPrice,
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
