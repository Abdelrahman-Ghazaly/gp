const mongoose = require("mongoose");
const Schema = mongoose.Schema;


const MessageSchema = new mongoose.Schema(
    {
        conversationId: {
            type: Schema.Types.ObjectId,
            ref: "Conversation",
            unique: true,
            required: true,
        },
        sender: {
            type: Schema.Types.ObjectId,
            ref: "User",
            unique: true,
            required: true,
        },
        text: {
            type: String,
            required: true,
        },
    },
    { timestamps: true }
);

const Message = mongoose.model("Message", MessageSchema);


exports.createMessage = async (conversationId, sender, text) => {
    try {
        const newMessage = new Message({ conversationId, sender, text });
        const result = await newMessage.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.getMessages = async (conversationId) => {
    try {
        const messages = await Message.find({
            conversationId: conversationId,
        });
        return messages;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};