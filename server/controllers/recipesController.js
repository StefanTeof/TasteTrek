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

const editRecipe = async (req,res)=>{
    try{
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

const deleteRecipe = async (req,res) => {
    try{
        const id=req.headers['id']
        const deletedRecipe= await Recipe.findByIdAndDelete(id)
        if(deletedRecipe){
            return res.status(200).json({err:"Successfully deleted"})
        }else{
            res.status(404).json({ message: 'Recipe not found' });
        }

    }catch(err){
        console.log(err)
        return res.status(500).json({msg:"Error while deleting"})
    }
}

module.exports = {getAllRecipes, addRecipe, editRecipe,deleteRecipe}