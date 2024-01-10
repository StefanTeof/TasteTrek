const express = require('express');
const router = express.Router();
const recipesController = require('../controllers/recipesController');

// GET routes
router.get('/getAllRecipes', recipesController.getAllRecipes);

// POST routes
router.post('/addRecipe', recipesController.addRecipe);

module.exports = router;