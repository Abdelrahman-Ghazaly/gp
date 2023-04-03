const joi = require("joi");

const validatior = (schema) => {
    return (request) => {
        return schema.validate(request, { abortEarly: false });
    };
};

const userSchema = joi.object({
    email: joi.string().email().required(),
    name: joi.string().min(3).max(15).required(),
    password: joi.string().min(5).max(10).required(),
    confirmPassword: joi.any().valid(joi.ref("password")).required(),
    address: joi.string().min(5).max(50).required(),
    phone: joi.string().required(),
});

const addOrderSchema = joi.object({
    address: joi.string().min(5).max(50).required(),
    cost: joi.number().required(),
});

const ProductSchema = joi.object({
    title: joi.string().min(3).max(15).required(),
    description: joi.string().min(5).max(50).required(),
    imgURL: joi.string().uri().required(),
    category: joi.string().min(3).max(15).required(),
    price: joi.number().required(),
});

exports.validateUserData = validatior(userSchema);

exports.validateOrderData = validatior(addOrderSchema);

exports.validateProductData = validatior(ProductSchema);
