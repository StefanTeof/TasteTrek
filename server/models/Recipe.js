const mongoose = require('mongoose');

mongoose.set('strictQuery', false);


const recipeSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    }
}, {timestamps: true});

const Recipe = mongoose.model('Recipe', recipeSchema);

module.exports = Recipe;