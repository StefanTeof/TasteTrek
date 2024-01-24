const express = require('express');
const router = express.Router();
const passport = require('passport')

const recipesController = require('../controllers/recipesController');

// GET routes
router.get('/getAllRecipes', recipesController.getAllRecipes);
router.get('/getRecipesByUser', passport.authenticate('user-jwt', {session: false}), recipesController.getRecipesByUser);

// POST routes
router.post('/addRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.addRecipe);
router.post('/editRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.editRecipe);

// Delete routes
router.delete('/deleteRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.deleteRecipe);


module.exports = router;