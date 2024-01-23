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
    }]
}, {timestamps: true});

const Recipe = mongoose.model('Recipe', recipeSchema);

module.exports = Recipe;