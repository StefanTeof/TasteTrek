const mongoose = require('mongoose');
const Recipe = require('../models/Recipe');
const User = require('../models/User');
const aws = require('../config/awss3');
const crypto = require('crypto');


const { PutObjectCommand, GetObjectCommand } = require('@aws-sdk/client-s3');


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

const getRecipesByUser = async(req, res) => {
    try{
        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."});
        }
        await User.populate(user, { path: 'recipes' });

        const recipes = user.recipes;

        console.log(user);

        return res.status(200).json({recipes: recipes})

    }catch(err){
        console.log("Error while getting recipes by user: ", err);
        return res.status(500).json({err: err });
    }
}

const getRecipeById = async(req, res) => {
    try{
        const recipeId = req.headers['id'];
        const recipe = await Recipe.findById(recipeId);
        
        if(!recipe){
            return res.status(503).json({err: "Recipe not found."})
        }

        let isRecipeBySameUser = false;
        if(req.user){
            isRecipeBySameUser = req.user._id.toString() === recipe.user.toString();    
        }
        
        return res.status(200).json({recipe: recipe, isRecipeBySameUser: isRecipeBySameUser});
    }catch(err){
        console.log("Error while getting recipes by user: ", err);
        return res.status(500).json({err: err});
    }
}


// Post Requests
const addRecipe = async(req, res) => {

    const session = await mongoose.startSession();
    session.startTransaction();
    try{
        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }
        const recipeData = req.body;
        if(!recipeData.name || typeof recipeData.name !== 'string' ){
            return res.status(503).json({err: "Invalid name"});
        };

        const imageUrl = req.file.location;
        const randomImageName = (bytes=32) => crypto.randomBytes(bytes).toString('hex');
        const imageName = `Avatars/${randomImageName()}`;
        const params = {
            Bucket: process.env.BUCKET_NAME,
            Key: imageName,
            Body : req.file.buffer,
            ContentType: req.file.mimetype,
        }

        const command = new PutObjectCommand(params);

        await aws.s3.send(command);

        await User.populate(user, { path: 'recipes' });

        if(user.recipes && user.recipes.some(recipe => recipe.name === recipeData.name)){
            return res.status(409).json({err: `This recipe already exists`});
        }

        const ingredientList = recipeData.ingredients.split(',');

        const newRecipe = new Recipe({
            name : recipeData.name,
            description : recipeData.description,
            image : imageUrl,
            ingredients : ingredientList,
            instructions: recipeData.instructions,
            calories: recipeData.calories ? recipeData.calories:0,
            carbs: recipeData.carbs ? recipeData.carbs:0,
            fats: recipeData.fats ? recipeData.fats:0,
            proteins: recipeData.proteins ? recipeData.proteins:0,
            user: req.user._id,
        })

        await newRecipe.save();

        await user.recipes.push(newRecipe._id);        

        await user.save()

        await session.commitTransaction();
        session.endSession();

        return res.status(200).json({msg: "Recipe added"});
    }catch(err){
        console.log("Error while adding recipe: ", err);
    }
}

const editRecipe = async (req,res)=>{
    try{
        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }
        const recipeId=req.headers['id']
        const recipe= await Recipe.findById(recipeId)
        console.log("Recipe: ", recipe);
        if(!recipe){
            return res.status(503).json({err: "Recipe not found."})
        }
       const isRecipeInUserList = user.recipes.includes(recipeId);

        if (!isRecipeInUserList) {
            return res.status(403).json({ err: "Recipe does not belong to the user." });
        }
        const update={$set:{name:req.body.name}}
        console.log(req.body)
        await Recipe.updateOne({_id:recipeId},update);
        return res.status(200).json({msg: "Recipe editted"});
    } catch(err){
        console.log(err)
        return res.status(500).json({err:err})
    }
}

// Delete requests
const deleteRecipe = async (req,res) => {
    try{
        const session = await mongoose.startSession();
        session.startTransaction();

        const user = req.user;
        if(!user){
            return res.status(503).json({err: "User have to be logged in for this action."})
        }

        const recipeId=req.headers['id']

        console.log(user.recipes);

        const isRecipePresent = user.recipes.includes(recipeId); // Check if the recipe is in the list of the logged in user recipes

        console.log(isRecipePresent)

        if(!isRecipePresent){
            return res.status(503).json({err: "This user does not have such recipe"})
        }
                
        const deletedRecipe= await Recipe.findByIdAndDelete(recipeId)
        if(!deletedRecipe){
            return res.status(404).json({err: 'Recipe not found' });
        }

        user.recipes.pop(recipeId);

        await user.save();

        await User.updateMany(
            { 'favorites': recipeId },
            { $pull: { 'favorites': recipeId } }
        );
        
        await session.commitTransaction();
        session.endSession();

        return res.status(200).json({msg :"Successfully deleted"})

    }catch(err){
        console.log(err)
        return res.status(500).json({msg:"Error while deleting"})
    }
}



module.exports = {getAllRecipes, addRecipe, editRecipe,deleteRecipe, getRecipesByUser, getRecipeById};