const db = require("../model/product");
const errors = require("../util/error_handling");
const { validateProductData } = require("../util/validation");
const { initializeApp } = require("firebase/app");
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
const { sanitizeFilter } = require("mongoose");

//Initialize a firebase application
initializeApp(firebaseConfig.firebaseConfig);

// Initialize Cloud Storage and get a reference to the service
const storage = getStorage();

exports.uploadImage = multer({
    storage: multer.memoryStorage(),
    fileFilter: multerConfig.fileFilter,
}).array((fieldName = "images"), (maxCount = 4));

exports.uploadToFirebase = async (req, res, next) => {
    try {
        const images = req.files;
        console.log(images)
        const imageURLs = [];
        if (!images) {
            errors.validationError("no images sent");
        }
        for (const image of images) {
            const dateTime = new Date();
            const storageRef = ref(
                storage,
                `products/${image.originalname + "       " + dateTime}`
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
        };
        req.imageURLs = imageURLs;
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.createProduct = async (req, res, next) => {
    try {
        const productData = req.body;
        const { error } = validateProductData(productData);
        if (error) {
            console.log(error.details)
            errors.validationError(error.details);
        }
        const result = await db.createProduct(
            productData,
            req.user.id,
            req.imageURLs
        );
        if (result) {
            res.status(201).json({ message: "product created Successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.deleteProductImages = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const { imgURL } = await db.getProductImagesForDeletation(productId,req.user.id);
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

exports.deleteProduct = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const result = await db.deleteProduct(productId, req.user.id);
        if (result) {
            res.status(200).json({ message: "product deleted Successfully" });
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.view = async (req, res, next) => {
    try {
        const result = await db.view();
        if (result) {
            res.status(200).json(result[0]);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.viewOneProduct = async (req, res, next) => {
    try {
        const productId = req.params.productId;
        const result = await db.viewOneProduct(productId);
        if (result) {
            res.status(200).json(result);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.search = async (req, res, next) => {
    try {
        const query = req.query.query;
        const minPrice = req.query.minPrice;
        const maxPrice = req.query.maxPrice;
        const category = req.query.category;
        const result = await db.search(query, category, minPrice, maxPrice);
        if (result) {
            res.status(200).json(result);
        } else {
            throw new Error();
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};
