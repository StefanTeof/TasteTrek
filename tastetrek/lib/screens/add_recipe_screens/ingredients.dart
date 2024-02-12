import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/instructions.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/ingredients.dart';
import 'package:tastetrek/widgets/header.dart';


class IngredientsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String category;

  IngredientsScreen({
    required this.name,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: MyAppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: IngredientsWidget(
          name: name,
          description: description,
          category: category,
        ),
      ),
    );

  }
}
