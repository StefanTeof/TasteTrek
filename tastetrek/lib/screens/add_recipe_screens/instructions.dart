import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/instructions.dart';
import 'package:tastetrek/widgets/header.dart';

class InstructionsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;

  InstructionsScreen({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InstructionsWidget(
          name: name,
          description: description,
          category: category,
          ingredientList: ingredientList
        ),
      ),
    );
  }
}
