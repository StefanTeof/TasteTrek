const mongoose = require('mongoose');

mongoose.set('strictQuery', false);


const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        match: [/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/, 'Invalid Email'],
    },
    username: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,  
        maxLength: 20,
    },
    password:{
        type: String,
        minLength: 6,
    },
    bio: {
        type: String,
        maxLength: 100,
    },
    country: {
        type: String
    },
    city: {
        type: String
    },
    // notifications: [{
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: 'Notification',
    // }],
    googleId: {
        type: String,
        unique: true,
        sparse: true,
    }
}, {timestamps: true});

const User = mongoose.model('User', userSchema);

module.exports = User;