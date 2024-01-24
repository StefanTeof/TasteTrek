const mongoose = require('mongoose');
const Recipe = require('../models/Recipe');
const User = require('../models/User');


const getFavoriteRecipes = async(req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();
    try{
        const isLoggedIn = req.user;
        if(!isLoggedIn){
            return res.status(503).json({err: "User not found"});
        }

        const user = await User.findById(req.user._id).populate('favorites').exec();

        if(!user){
            return res.status(503).json({err: "User not found"});
        }

        const favorites = user.favorites;

        await session.commitTransaction();
        session.endSession();

        res.status(200).json({favorites: favorites, msg: "Successful getting favorite recipe"});

    }catch(err){
        console.error("Error in getting favorite recipes", err);
        return res.status(500).json({err: "Internal server error"});

    }

}


const addRecipeToFavorites = async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();

    try{
        const isLoggedIn = req.user;
        if(!isLoggedIn) {
            return res.status(503).json({err: "User have to be logged in for this action."});
        }

        const user = await User.findById(req.user._id);

        const recipe = await Recipe.findById(req.body.recipeId);

        if(!recipe){
            return res.status(404).json({err:"Recipe was not found."})
        }

        user.favorites.push(recipe._id);

        user.save();
                    
        await session.commitTransaction();
        session.endSession();

        return res.status(200).json({msg :"Successfully added to favorites"})
    }catch(err){
        console.log("Error while adding recipe to favorites: ", err);
        return res.status(500).json({err: "Internal server error"}); 
    }
}

// TODO: Add remove from favorites api

module.exports = {addRecipeToFavorites, getFavoriteRecipes};

