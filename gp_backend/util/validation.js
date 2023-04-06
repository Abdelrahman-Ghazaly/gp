const joi = require("joi");

const validatior = (schema) => {
    return (request) => {
        return schema.validate(request, { abortEarly: false });
    };
};

const userSchema = joi.object({
    email: joi.string().email().required(),
    name: joi.string().min(3).required(),
    password: joi.string().min(5).required(),
    confirmPassword: joi.any().valid(joi.ref("password")).required(),
    address: joi.string().min(5).required(),
    phone: joi.string().required(),
});


const ProductSchema = joi.object({
    title: joi.string().min(3).required(),
    description: joi.string().min(3).required(),
    category: joi.string().min(3).required(),
    price: joi.number().required(),
    
    // images: joi.required()
    
});

exports.validateUserData = validatior(userSchema);

exports.validateProductData = validatior(ProductSchema);
