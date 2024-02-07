import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  final _recipes = <Recipe>[].obs;

  List<Recipe> get recipes => _recipes;
  
  void fetchRecipes() {
    // Simulating fetching recipes from an API
    _recipes.assignAll([
      Recipe(
        title: 'Recipe 1',
        description: 'Description for Recipe 1',
        imageUrl: '',
      ),
      Recipe(
        title: 'Recipe 2',
        description: 'Description for Recipe 2',
        imageUrl: '',
      ),
      Recipe(
        title: 'Recipe 3',
        description: 'Description for Recipe 3',
        imageUrl: '',
      ),
    ]);
  }
}

class Recipe {
  final String title;
  final String description;
  final String imageUrl;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
