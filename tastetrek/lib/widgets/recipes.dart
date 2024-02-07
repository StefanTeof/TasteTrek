import 'package:flutter/material.dart';

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
  final String title;
  final String description;
  final String imageUrl;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class RecipeGrid extends StatefulWidget {
  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // Fetch recipes when the page loads
  }

  // Temporary list of recipes for testing
  void fetchRecipes() {
    setState(() {
      recipes = [
        Recipe(
          title: 'Recipe 1',
          description: 'Description for Recipe 1',
          imageUrl: 'https://via.placeholder.com/300',
        ),
        Recipe(
          title: 'Recipe 2',
          description: 'Description for Recipe 2',
          imageUrl: 'https://via.placeholder.com/300',
        ),
        Recipe(
          title: 'Recipe 3',
          description: 'Description for Recipe 3',
          imageUrl: 'https://via.placeholder.com/300',
        ),
        // Add more recipes as needed
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle item click
              print('Clicked on recipe: ${recipes[index].title}');
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      recipes[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipes[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     recipes[index].description,
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
