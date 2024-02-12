const mongoose = require('mongoose');

const User = require("../models/User");
const aws = require('../config/awss3');
const crypto = require('crypto');


const { PutObjectCommand, GetObjectCommand } = require('@aws-sdk/client-s3');

// Get Requests
const getUser = async (req, res) => {
    try {
        if (!req.user) {
            return res.status(503).json({ err: "User not found" });
        }
        const user = await User.findById(req.user._id).select('-password');

        return res.status(200).json({ user });
    } catch (err) {
        console.log("Error while getting user", err);
        return res.status(500).json({ err });
    }
};


// Post requests

const editUser = async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();
    try {
        if (!req.user) {
            return res.status(503).json({ err: "User not found" });
        }
        let imageUrl = '';
        if (req.file) {
            imageUrl = req.file.location;
            const randomImageName = (bytes = 32) => crypto.randomBytes(bytes).toString('hex');
            const imageName = `Avatars/${randomImageName()}`;
            const params = {
                Bucket: process.env.BUCKET_NAME,
                Key: imageName,
                Body: req.file.buffer,
                ContentType: req.file.mimetype,
            }
            const command = new PutObjectCommand(params);

            await aws.s3.send(command);

        }

        const { username, email, ...otherFields } = req.body;
        const location = otherFields.location;

        const existingUserByUsername = await User.findOne({ username });
        const existingUserByEmail = await User.findOne({ email });

        if (existingUserByUsername && existingUserByUsername._id.toString() !== req.user._id.toString()) {
            return res.status(400).json({ err: "Username is already taken" });
        }

        if (existingUserByEmail && existingUserByEmail._id.toString() !== req.user._id.toString()) {
            return res.status(400).json({ err: "Email is already in use" });
        }

        const updatedUser = await User.findByIdAndUpdate(
            req.user._id,
            { username, email, ...otherFields, image: imageUrl, location },
            { new: true, runValidators: true }
        ).select('-password');

        await session.commitTransaction();
        session.endSession();

        return res.status(200).json({ user: updatedUser, msg: "User updated successfully" });
    } catch (err) {
        console.log("Error while editing user", err);
        return res.status(500).json({ err });
    }
};


module.exports = { getUser, editUser }