const mongoose = require('mongoose');

mongoose.set('strictQuery', false);


const recipeSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    image: {
        type: String // TODO: add aws3 bucket to upload images
        // required: true
    },
    ingredients: [{
        type: String,
        required: true
    }],
    user: {
        type: mongoose.Schema.Types.ObjectId, ref: 'User',
        required: true
    },
    calories: {
        type: Number,
    },
    carbs: {
        type: Number,
    },
    // TODO: Add type (breakfast, lunch, dinner, snack..), Add type 2 (sweat, sour, normal), Add type 3 (healthy, burgers.. ), More types if needed
}, {timestamps: true});

const Recipe = mongoose.model('Recipe', recipeSchema);

module.exports = Recipe;