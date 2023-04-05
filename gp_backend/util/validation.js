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
    title: joi.string().min(3).max(15).required(),
    description: joi.string().min(5).max(50).required(),
    category: joi.string().min(3).max(15).required(),
    price: joi.number().required(),
<<<<<<< HEAD
    
    // images: joi.required()
    
=======
>>>>>>> 546a0dfab0cfa74cacfc3fbd76d0502d8f7402ee
});

exports.validateUserData = validatior(userSchema);

exports.validateProductData = validatior(ProductSchema);
