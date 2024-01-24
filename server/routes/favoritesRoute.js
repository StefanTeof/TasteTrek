const express = require('express');
const router = express.Router();
const passport = require('passport')

const favoritesController = require('../controllers/favoritesController');

// GET Requests
router.get('/getFavoriteRecipes', passport.authenticate('user-jwt', {session: false}), favoritesController.getFavoriteRecipes);

// Post Requests
router.post('/addRecipeToFavorites', passport.authenticate('user-jwt', {session: false}), favoritesController.addRecipeToFavorites);

// Delete Requests
router.delete('/removeRecipeFromFavorites', passport.authenticate('user-jwt', {session: false}), favoritesController.removeRecipeFromFavorites);

module.exports = router;