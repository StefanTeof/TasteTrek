const mongoose = require('mongoose');
const Recipe = require('../models/Recipe');
const User = require('../models/User');

//Get Requests
const getAllRecipes = async(req, res) => {
    try{
        const recipes = await Recipe.find({})
        return res.status(200).json({recipes: recipes});
    }catch(err){
        console.log("Error while getting all recipes: ", err);
        return res.status(500).json({err: err});
    }
}

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


// Post Requests
const addRecipe = async(req, res) => {
    try{
        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }
        const {name, description, image, ingredients} = req.body;
        if(!name || typeof name !== 'string' ){
            return res.status(503).json({err: "Invalid name"});
        };
        const newRecipe = new Recipe({
            name : name,
            description : description ? description : "",
            image : image ? image : "",
            ingredients : ingredients ? ingredients : []
        })

        await newRecipe.save();
        return res.status(200).json({msg: "Recipe added"});
    }catch(err){
        console.log("Error while adding recipe: ", err);
    }
}

const editRecipe = async (req,res)=>{
    // TODO: Check if the logged in user has the recipe in their list
    try{
        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }
        const id=req.headers['id']
        const recipe=Recipe.findById(id)
        if(!recipe){
            return res.status(503).json({err: "Recipe not found."})
        }
        const update={$set:{name:req.body.name}}
        console.log(req.body)
        await Recipe.updateOne({_id:id},update,(err,value)=>
        {
            console.log(err)
        }).exec()
        return res.status(200).json({msg: "Recipe editted"});
    } catch(err){
        console.log(err)
        return res.status(500).json({err:err})
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


// Delete requests
const deleteRecipe = async (req,res) => {
    try{
        const session = await mongoose.startSession();
        session.startTransaction();

        const isLoggedIn = req.user;
        if(!isLoggedIn){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }

        const user = await User.findById(req.user._id).populate('recipes').exec(); 

        if(!user){
            return res.status(503).json({err: "The user does not exists"});
        }
        const id=req.headers['id']

        const isRecipePresent = user.recipes.map(recipe => recipe._id).includes(id); // Check if the recipe is in the list of the logged in user recipes

        if(!isRecipePresent){
            return res.status(503).json({err: "This user does not have such recipe"})
        }
                
        const deletedRecipe= await Recipe.findByIdAndDelete(id)
        if(!deletedRecipe){
            return res.status(404).json({err: 'Recipe not found' });
        }
        
        await session.commitTransaction();
        session.endSession();

        return res.status(200).json({msg :"Successfully deleted"})

    }catch(err){
        console.log(err)
        return res.status(500).json({msg:"Error while deleting"})
    }
}



module.exports = {getAllRecipes, addRecipe, editRecipe,deleteRecipe, addRecipeToFavorites, getFavoriteRecipes};