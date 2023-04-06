const errors = require("./error_handling");
const { initializeApp } = require("firebase/app");
const productDb = require("../model/product")
const {
    getStorage,
    ref,
    getDownloadURL,
    uploadBytesResumable,
    deleteObject,
} = require("firebase/storage");
const firebaseConfig = require("../config/firebase.config");
const multerConfig = require("../config/multer.config");
const multer = require("multer");

//Initialize a firebase application
initializeApp(firebaseConfig.firebaseConfig);

// Initialize Cloud Storage and get a reference to the service
const storage = getStorage();

exports.uploadImage = multer({
    storage: multer.memoryStorage(),
    fileFilter: multerConfig.fileFilter,
}).array((fieldName = "imgURL"), (maxCount = 4));

exports.uploadToFirebase = async (req, res, next) => {
    try {
        const images = req.files;
        const imageURLs = [];
        if (!images[0]) {
            errors.validationError("no images sent");
        }
        for (const image of images) {
            const dateTime = new Date();
            const storageRef = ref(
                storage,
                `products/${image.originalname + dateTime}`
            );
            const metadata = {
                contentType: image.mimetype,
            };
            const snapshot = await uploadBytesResumable(
                storageRef,
                image.buffer,
                metadata
            );
            const URL = await getDownloadURL(snapshot.ref);
            imageURLs.push(URL);
        }
        req.imageURLs = imageURLs;
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};


exports.deleteProductImages = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const { imgURL } = await productDb.getProductImagesForDeletation(
            productId,
            req.user.id
        );
        for (const img of imgURL) {
            const desertRef = ref(storage, img);
            await deleteObject(desertRef);
        }
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};