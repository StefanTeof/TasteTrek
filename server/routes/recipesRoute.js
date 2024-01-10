const express = require('express');
const router = express.Router();
const recipesController = require('../controllers/recipesController');

// GET routes
router.get('/getAllRecipes', recipesController.getAllRecipes);
router.delete('/deleteRecipe', recipesController.deleteRecipe);


// POST routes
router.post('/addRecipe', recipesController.addRecipe);
router.post('/editRecipe', recipesController.editRecipe);

module.exports = router;