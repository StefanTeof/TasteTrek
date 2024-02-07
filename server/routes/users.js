const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const User = require('../models/User');
const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');

const crypto = require('crypto');

require('../config/passport');
require('dotenv').config();

router.post('/register', async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();
    try {
        const { firstName, lastName, email, username, password } = req.body;

        const user = await User.findOne({ $or: [{ email: email }, { username: username }] });
        if (user) {
            return res.status(409).json({ err: "User With Same Email/Username Already Exists" });
        }
        else {
            // check any validation if needed

            //hash the password before saving it to database
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);

            const newUser = User({
                firstName,
                lastName,
                email,
                username,
                password: hashedPassword,
            });

            const savedUser = await newUser.save();

            await session.commitTransaction();
            session.endSession();
            
            const payload = {
                username: savedUser.username,
                id: savedUser._id
            }   

            const token = jwt.sign(payload, process.env.JWT_SECRET_KEY, { expiresIn: "30d" });

            return res.status(200).json({ msg: 'User Registered Successfuly', token: "Bearer " + token });
        }
    } catch (err) {
        await session.abortTransaction();
        session.endSession();
        return res.status(500).json({ err: err, msg: "Register Internval Server Error" });
    }
})


router.post('/login', async (req, res) => {

    const { username, password } = req.body;

    try {
        const user = await User.findOne({ username: username });
        if (!user) {
            return res.status(401).json({ err: "Username Does Not Exist" });
        }
        if (!bcrypt.compare(password, user.password)) {
            return res.status(401).json({ err: "Incorrect Password" });
        }

        const payload = {
            username: user.username,
            id: user._id
        }

        const token = jwt.sign(payload, process.env.JWT_SECRET_KEY, { expiresIn: "30d" });

        return res.status(200).json({ token: "Bearer " + token, msg: "Successful Login" });

    } catch (err) {
        return res.status(500).json({ err: "Login Internal Error" });
    }
})


module.exports = router;
