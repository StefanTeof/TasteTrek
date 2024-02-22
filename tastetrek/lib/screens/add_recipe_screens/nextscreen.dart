import 'package:flutter/material.dart';


class NextScreen extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;
  final String calories;
  final String carbs;
  final String fats;
  final String proteins;

  NextScreen({
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
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Category: $category',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Ingredients: $ingredientList',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Instructions: $instructions',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientList
          .map((ingredient) => Text(
                '- $ingredient',
                style: TextStyle(fontSize: 18),
              ))
          .toList(),
    );
  }
}