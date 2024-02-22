import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Recipe {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;
  final int calories;
  final int carbs;
  final int fats;
  final int proteins;
  final String imageUrl;
  final bool isRecipeBySameUser;

  Recipe({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.ingredientList,
    required this.instructions,
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.isRecipeBySameUser,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      ingredientList: json['ingredients'] != null ? List<String>.from(json['ingredients']) : [],
      instructions: json['instructions'],
      calories: json['calories'],
      carbs: json['carbs'],
      fats: json['fats'],
      proteins: json['proteins'],
      imageUrl: json['image'],
      isRecipeBySameUser: json['isRecipeBySameUser'] ?? false,
    );
  }
}

class RecipeDetailWidget extends StatefulWidget {
  final String recipeId;

  const RecipeDetailWidget({required this.recipeId});

  @override
  _RecipeDetailWidgetState createState() => _RecipeDetailWidgetState();
}

class _RecipeDetailWidgetState extends State<RecipeDetailWidget> {
  Recipe? recipe;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  void fetchRecipe() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "auth_token");
    print(token);
    var response = await http.get(
      Uri.parse(
          'http://localhost:5000/api/recipes/getRecipeById/${widget.recipeId}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token!,
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var recipeData =
          responseData['recipe'];
      print('Recipe Data: $recipeData');
      setState(() {
        recipe = Recipe.fromJson(
            recipeData); // Pass the extracted recipe object to fromJson
      });
    } else {
      throw Exception('Failed to load recipe: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if recipe data is still loading or has been loaded.
    if (recipe == null) {
      // Data is still loading
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading Recipe...'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      // Data has been loaded, display the recipe details
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                recipe!.imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipe!.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipe!.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Nutrition per 100g: Calories: ${recipe!.calories}, Carbs: ${recipe!.carbs}g, Fats: ${recipe!.fats}g, Proteins: ${recipe!.proteins}g',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredients:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    ...recipe!.ingredientList
                        .map((ingredient) => ListTile(
                              title: Text(ingredient),
                              leading: Icon(Icons.check_circle_outline),
                            ))
                        .toList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Instructions:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipe!.instructions,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
