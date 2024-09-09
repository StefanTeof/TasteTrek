import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tastetrek/screens/profile_screen.dart';
import 'package:tastetrek/utils/server_url.dart';

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
  final String userId;
  final String username;

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
    required this.userId,
    required this.username,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      ingredientList: json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : [],
      instructions: json['instructions'],
      calories: json['calories'],
      carbs: json['carbs'],
      fats: json['fats'],
      proteins: json['proteins'],
      imageUrl: json['image'],
      userId: json['user']['_id'],
      username: json['user']['username'],
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
  bool isRecipeBySameUser = false;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  void fetchRecipe() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "auth_token");
    var response = await http.get(
      Uri.parse('${getBaseUrl()}api/recipes/getRecipeById/${widget.recipeId}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token!,
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var recipeData = responseData['recipe'];

      setState(() {
        recipe = Recipe.fromJson(recipeData);
        isRecipeBySameUser = responseData['isRecipeBySameUser'];
        print("Is recipe by same user: ${isRecipeBySameUser}");
      });
    } else {
      throw Exception('Failed to load recipe: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading Recipe...'),
          automaticallyImplyLeading: false,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            title: Text('Recipe Details'), automaticallyImplyLeading: false),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recipe!.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    if (isRecipeBySameUser) // Check using the updated variable
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to the Edit Recipe screen
                        },
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to user's profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          userId: recipe!.userId),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '@${recipe!.username}',
                    style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  ),
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100, // Light orange background
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for outer border
                    border: Border.all(
                      color: Colors.black, // Black border
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside:
                          BorderSide(color: Colors.black, width: 1),
                      verticalInside: BorderSide(color: Colors.black, width: 1),
                    ),
                    children: [
                      TableRow(
                        children: [
                          _buildNutritionCell(
                              'Calories', '${recipe!.calories}'),
                          _buildNutritionCell('Carbs', '${recipe!.carbs}g'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildNutritionCell('Fats', '${recipe!.fats}g'),
                          _buildNutritionCell(
                              'Proteins', '${recipe!.proteins}g'),
                        ],
                      ),
                    ],
                  ),
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

  Widget _buildNutritionCell(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
