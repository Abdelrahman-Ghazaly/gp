require("dotenv").config();
const mongoose = require("mongoose");

const mongoParams = {
    useNewUrlParser: true,
    useUnifiedTopology: true,
};

module.exports = {
    init: () => {
        try {
            mongoose.connect(
                `mongodb+srv://${process.env.DATABASE_USER}:${process.env.DATABASE_PASSWORD}@gradproject.d6vsdpg.mongodb.net/${process.env.DATABASE_NAME}?retryWrites=true&w=majority`,
                mongoParams
            );
            console.log("db connected");
        } catch (err) {
            console.log(err);
        }
    },
};
