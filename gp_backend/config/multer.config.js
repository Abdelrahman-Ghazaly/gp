exports.fileFilter = (req, file, cb) => {
    if (
        file.mimetype === "image/png" ||
        file.mimetype === "image/jpg" ||
        file.mimetype === "image/jpeg" ||
        file.mimetype === "image/jfif" ||
        file.mimetype === "image/pjpeg" ||
        file.mimetype === "image/pjp"
    ) {
        cb(null, true);
    } else {
        cb(new Error("Wrong file Type"));
    }
};
