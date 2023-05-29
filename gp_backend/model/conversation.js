const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ConversationSchema = new mongoose.Schema(
    {
        members: [
            {
                type: Schema.Types.ObjectId,
                ref: "User",
                required: true,
            },
        ],
    },
    { timestamps: true }
);

const Conversation = mongoose.model("Conversation", ConversationSchema);

exports.createConversation = async (senderId, receiverId) => {
    try {
        const newConversation = new Conversation({
            members: [senderId, receiverId],
        });
        const result = await newConversation.save();
        return result;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};


exports.getUserConversations = async (userId) => {
    try {
        const conversation = await Conversation.find({
            members: { $in: [userId] },
        });
        return conversation;
    } catch (err) {
        console.log(err);
        throw new Error();
    }
};