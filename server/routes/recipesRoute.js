const express = require('express');
const router = express.Router();
const passport = require('passport')

const recipesController = require('../controllers/recipesController');

// GET routes
router.get('/getAllRecipes', recipesController.getAllRecipes);
router.delete('/deleteRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.deleteRecipe);
router.get('/getFavoriteRecipes', passport.authenticate('user-jwt', {session: false}), recipesController.getFavoriteRecipes);


// POST routes
router.post('/addRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.addRecipe);
router.post('/editRecipe', passport.authenticate('user-jwt', {session: false}), recipesController.editRecipe);
router.post('/addRecipeToFavorites', passport.authenticate('user-jwt', {session: false}), recipesController.addRecipeToFavorites);

module.exports = router;