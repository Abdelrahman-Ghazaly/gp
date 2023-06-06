
// let server;
// module.exports = (http) => {
//     server = http
// } 
const io = require("socket.io")(5002, {
    cors: {
        origin: "*",
    },
});
// module.exports = io 
global.users = [];

const addUser = (userId, socketId) => {
    !global.users.some((user) => user.userId === userId) &&
        global.users.push({ userId, socketId });
};


const removeUser = (socketId) => {
    users = global.users.filter((user) => user.socketId !== socketId);
};

const getUser = (userId) => {
    //console.log(global.users);
    return global.users.find((user) => user.userId === userId);
};

io.on("connection", (socket) => {
    //when ceonnect
    console.log("a user connected.");

    //take userId and socketId from user
    socket.on("addUser", (userId) => {
        addUser(userId, socket.id);
        io.emit("getUsers", users);
    });

    
    //send and get message
    socket.on("sendMessage", ({ senderId, receiverId, text }) => {
        const user = getUser(receiverId);
        //console.log(text);
        console.log(user);
        io.to(user?.socketId).emit("getMessage", {
            senderId,
            text,
        });
    });

    //when disconnect
    socket.on("disconnect", () => {
        console.log("a user disconnected!");
        removeUser(socket.id);
        io.emit("getUsers", users);
    });
});

exports.emitBidAuction = (auctionData) => {
    io.emit("bidAuction", auctionData);
}
