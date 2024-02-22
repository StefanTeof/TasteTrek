import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/footer.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/single_recipe.dart';


class RecipeDetailScreen extends StatelessWidget {
  final String recipeId; 

  RecipeDetailScreen({
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: RecipeDetailWidget(recipeId: recipeId),
      bottomNavigationBar: MyAppFooter(),
    );
  }
}