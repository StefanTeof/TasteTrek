import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastetrek/screens/single_recipe_screen.dart';
import 'package:tastetrek/utils/server_url.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  late List<Recipe> favoriteRecipes = [];
  late List<Recipe> filteredRecipes = [];

  TextEditingController searchController = TextEditingController();
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes(); // Fetch liked recipes when the page loads
  }

  void fetchFavoriteRecipes() async {
    final String? authToken = await _storage.read(key: 'auth_token');
    if (authToken == null) {
      print('Error: Authorization token is missing');
      return;
    }
    try {
      var url = Uri.parse('${getBaseUrl()}api/favorites/getFavoriteRecipes');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Ensure 'favorites' exists and is not null
        if (data != null && data['favorites'] != null) {
          setState(() {
            favoriteRecipes = List<Recipe>.from(data['favorites'].map((recipeJson) => Recipe(
              id: recipeJson['_id'] ?? '',
              title: recipeJson['name'] ?? '',
              description: recipeJson['description'] ?? '',
              imageUrl: recipeJson['image'] ?? '',
              category: recipeJson['category'] ?? '',
            )));

            filteredRecipes = List.from(favoriteRecipes);
          });
        } else {
          print('No favorite recipes found in the response.');
        }
      } else {
        print('Failed to fetch favorite recipes: ${response.statusCode}');
      }
    } catch (err) {
      print('Error while fetching favorite recipes: $err');
    }
  }


  void filterRecipes(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredRecipes = favoriteRecipes.where((recipe) {
          return recipe.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        filteredRecipes = List.from(favoriteRecipes);
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
        filteredRecipes = favoriteRecipes.where((recipe) {
          return selectedCategories.contains(recipe.category);
        }).toList();
      } else {
        filteredRecipes = List.from(favoriteRecipes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterCategoriesSheet();
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
        automaticallyImplyLeading: false,
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
      ),
    );
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
                    children: favoriteRecipes
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
