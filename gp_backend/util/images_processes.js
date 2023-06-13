const errors = require("./error_handling");
const { initializeApp } = require("firebase/app");
const productDb = require("../model/product");
const axios = require("axios");
const {
    getStorage,
    ref,
    getDownloadURL,
    uploadBytesResumable,
    deleteObject,
} = require("firebase/storage");
const firebaseConfig = require("../config/firebase.config");
const multerConfig = require("../config/multer.config");
const { categoriesFilter } = require("../config/AI_model_categories");
const multer = require("multer");

//Initialize a firebase application
initializeApp(firebaseConfig.firebaseConfig);

// Initialize Cloud Storage and get a reference to the service
const storage = getStorage();

exports.uploadImage = multer({
    storage: multer.memoryStorage(),
    fileFilter: multerConfig.fileFilter,
}).single((fieldName = "imgURL"));

const roboflowRequest = async (image) => {
    try {
        const params = {
            api_key: "7CVuFQZ0jkW9W7LywkTh",
        };
        const headers = {
            "Content-Type": "application/x-www-form-urlencoded",
        };
        const response = await axios.post(
            "https://detect.roboflow.com/furniture-detection-qiufc/20",
            image,
            {
                params,
                headers,
            }
        );
        const data = await response.data["predictions"];
        let predictions = [];
        for (let index = 0; index < data.length ; index++) {
            predict = data[index];
            if (predict["class"] && predict["confidence"]) {
                predictions.push(predict);
            }
        }
        return predictions;
    } catch (err) {
        throw err;
    }
};

const getImageCategory = async (image) => {
    try {
        const predictions = await roboflowRequest(image);
        !predictions[0] && errors.validationError("Image isn't Clear");
        let prediction = predictions[0]["class"];
        for (let index = 0; index < predictions.length ; index++) {
            const predict = predictions[index];
            if (predictions.length - 1 == index) {
                break;
            }
            if (predict["confidence"] < predictions[index + 1]["confidence"]) {
                prediction = predictions[index + 1]["class"];
            }
        }
        !categoriesFilter[prediction.toLowerCase()] &&
            errors.validationError("Image isn't Clear");
        return categoriesFilter[prediction.toLowerCase()];
    } catch (err) {
        throw err;
    }
};

exports.classifyImageCategory = async (req, res, next) => {
    try {
        const image = req.file;
        if (!image) {
            errors.validationError("no image sent");
        }
        const imageBase64File = image.buffer.toString("base64");
        categoriesFilter;
        const prediction = await getImageCategory(imageBase64File);
        req.category = prediction;
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.uploadToFirebase = async (req, res, next) => {
    try {
        const image = req.file;
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
        req.imageURL = URL;
        next();
    } catch (err) {
        console.log(err);
        next(err);
    }
};

exports.deleteProductImages = async (imgURL) => {
    try {
        for (const img of imgURL) {
            const desertRef = ref(storage, img);
            await deleteObject(desertRef);
        }
    } catch (err) {
        console.log(err);
        next(err);
    }
};
