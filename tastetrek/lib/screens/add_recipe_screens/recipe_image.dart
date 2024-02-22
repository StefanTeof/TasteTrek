import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/instructions.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/nutrition.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/recipe_image.dart';
import 'package:tastetrek/widgets/header.dart';

class RecipeImageScreen extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;
  final String calories;
  final String carbs;
  final String fats;
  final String proteins;

  RecipeImageScreen({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList,
    required this.instructions,
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.proteins
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SubmitRecipeWidget(
          name: name,
          description: description,
          category: category,
          ingredientList: ingredientList,
          instructions: instructions,
          calories: calories,
          carbs: carbs,
          fats: fats,
          proteins: proteins,
        ),
      ),
    );
  }
}
