import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeService {
  final String baseUrl = 'http://localhost:5000/api/recipes';

  Future<void> addRecipe(List<Map<String, dynamic>> recipes, String authToken) async {
     for (var recipeData in recipes) {
      final Map<String, dynamic> requestData = {
      'name': recipeData['name'],
      'description': recipeData['description'],
      'ingredients': recipeData['ingredients'],
      'calories': recipeData['calories'],
      // Add other fields as needed
    };


    final http.Response response = await http.post(
      Uri.parse('$baseUrl/addRecipe'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Recipe added successfully');
    } else {
      print('Error adding recipe: ${response.body}');
    }
  }
}
}