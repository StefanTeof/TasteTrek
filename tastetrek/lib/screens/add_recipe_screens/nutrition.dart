import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/instructions.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/nutrition.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/footer.dart';

class NutritionScreen extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;

  NutritionScreen({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList,
    required this.instructions
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NutritionInfoWidget(
          name: name,
          description: description,
          category: category,
          ingredientList: ingredientList,
          instructions: instructions,
        ),
      ),
      bottomNavigationBar: MyAppFooter(),
    );
  }
}
