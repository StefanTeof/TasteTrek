const Recipe = require('../models/Recipe')

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


// Post Requests
const addRecipe = async(req, res) => {
    try{
        const {name} = req.body;
        if(!name || typeof name !== 'string' ){
            return res.status(503).json({err: "Invalid name"});
        };
        const newRecipe = new Recipe({
            name : name
        })

        await newRecipe.save();
        return res.status(200).json({msg: "Recipe added"});
    }catch(err){
        console.log("Error while adding recipe: ", err);
    }
}

module.exports = {getAllRecipes, addRecipe}