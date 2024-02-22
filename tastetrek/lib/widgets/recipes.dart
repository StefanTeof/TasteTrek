import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastetrek/screens/single_recipe_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Page Example',
      home: RecipeGrid(),
    );
  }
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}

class RecipeGrid extends StatefulWidget {
  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  late List<Recipe> recipes = [];
  late List<Recipe> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // Fetch recipes when the page loads
  }

  void fetchRecipes() async {
    try {
      var url = Uri.parse('http://localhost:5000/api/recipes/getAllRecipes');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // print(response.body);
        var data = json.decode(response.body);
        setState(() {
          // Assuming the response structure matches the Recipe model
          recipes =
              List<Recipe>.from(data['recipes'].map((recipeJson) => Recipe(
                    id: recipeJson['_id'],
                    title: recipeJson['name'],
                    description: recipeJson['description'],
                    imageUrl: recipeJson['image'],
                    category: recipeJson['category'],
                  )));

          // Assign the fetched recipes to filteredRecipes
          filteredRecipes = List.from(recipes);
        });
      } else {
        print('Failed to fetch recipes: ${response.statusCode}');
        // Handle error appropriately
      }
    } catch (err) {
      print('Error while fetching recipes: $err');
      // Handle error appropriately
    }
  }

  void filterRecipes(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredRecipes = recipes.where((recipe) {
          return recipe.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        filteredRecipes = List.from(recipes);
      }
    });
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
      filterRecipesByCategory();
    });
  }

  void filterRecipesByCategory() {
    setState(() {
      if (selectedCategories.isNotEmpty) {
        filteredRecipes = recipes.where((recipe) {
          return selectedCategories.contains(recipe.category);
        }).toList();
      } else {
        filteredRecipes = List.from(recipes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recipes'),
          actions: [
            IconButton(
              onPressed: () {
                // Show filter categories popup
                _showFilterCategoriesSheet();
              },
              icon: Icon(Icons.filter_list),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterRecipes(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search Recipes',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: filteredRecipes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle item click
                      String recipeId = filteredRecipes[index].id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailScreen(recipeId: recipeId)),
                      );
                      print(filteredRecipes[index].id);
                      print(
                          'Clicked on recipe: ${filteredRecipes[index].title}');
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Image.network(
                              filteredRecipes[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredRecipes[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredRecipes[index].description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  void _showFilterCategoriesSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter Categories',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: recipes
                        .map(
                          (recipe) => GestureDetector(
                            onTap: () {
                              setState(() {
                                toggleCategory(recipe.category);
                              });
                            },
                            child: Chip(
                              label: Text(recipe.category),
                              backgroundColor:
                                  selectedCategories.contains(recipe.category)
                                      ? Colors.orange
                                      : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Apply Filters'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
