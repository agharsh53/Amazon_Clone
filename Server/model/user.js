const mongoose = require('mongoose');
const {productSchema} = require('./product');  // Adjust the path if necessary

const userSchema = mongoose.Schema({
    name: {
        require: true,
        type: String,
        trim: true
    },
    email: {
        require: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$/;
                return value.match(re);
            },
            message: "Enter the valid email address"
        }
    },
    password: {
        type: String,
        default: "",
        validate: {
            validator: (value) => {
                return value.length >= 6;
            },
            message: "Password must be 6 characters or more."
        },
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: "user"
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true
            },
        },
    ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
