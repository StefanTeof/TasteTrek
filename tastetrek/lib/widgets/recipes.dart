// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material Page Example',
//       home: RecipeGrid(),
//     );
//   }
// }

// class Recipe {
//   final String title;
//   final String description;
//   final String imageUrl;

//   Recipe({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//   });
// }

// class RecipeGrid extends StatefulWidget {
//   @override
//   _RecipeGridState createState() => _RecipeGridState();
// }

// class _RecipeGridState extends State<RecipeGrid> {
//   late List<Recipe> recipes;

//   @override
//   void initState() {
//     super.initState();
//     fetchRecipes(); // Fetch recipes when the page loads
//   }

//   // Temporary list of recipes for testing
//   void fetchRecipes() {
//     setState(() {
//       recipes = [
//         Recipe(
//           title: 'Recipe 1',
//           description: 'Description for Recipe 1',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         Recipe(
//           title: 'Recipe 2',
//           description: 'Description for Recipe 2',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         Recipe(
//           title: 'Recipe 3',
//           description: 'Description for Recipe 3',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         // Add more recipes as needed
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.builder(
//         itemCount: recipes.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               // Handle item click
//               print('Clicked on recipe: ${recipes[index].title}');
//             },
//             child: Card(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child: Image.network(
//                       recipes[index].imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       recipes[index].title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       recipes[index].description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material Page Example',
//       home: RecipeGrid(),
//     );
//   }
// }

// class Recipe {
//   final String title;
//   final String description;
//   final String imageUrl;

//   Recipe({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//   });
// }

// class RecipeGrid extends StatefulWidget {
//   @override
//   _RecipeGridState createState() => _RecipeGridState();
// }

// class _RecipeGridState extends State<RecipeGrid> {
//   late List<Recipe> recipes;
//   late List<Recipe> filteredRecipes;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchRecipes(); // Fetch recipes when the page loads
//   }

//   // Temporary list of recipes for testing
//   void fetchRecipes() {
//     setState(() {
//       recipes = [
//         Recipe(
//           title: 'Recipe 1',
//           description: 'Description for Recipe 1',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         Recipe(
//           title: 'Recipe 2',
//           description: 'Description for Recipe 2',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         Recipe(
//           title: 'Recipe 3',
//           description: 'Description for Recipe 3',
//           imageUrl: 'https://via.placeholder.com/300',
//         ),
//         // Add more recipes as needed
//       ];
//       filteredRecipes = List.from(recipes);
//     });
//   }

//   void filterRecipes(String query) {
//     setState(() {
//       if (query.isNotEmpty) {
//         filteredRecipes = recipes.where((recipe) {
//           return recipe.title.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       } else {
//         filteredRecipes = List.from(recipes);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recipes'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Show filter categories popup
//             },
//             icon: Icon(Icons.filter_list),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: (value) {
//                 filterRecipes(value);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search Recipes',
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: filteredRecipes.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Handle item click
//                     print('Clicked on recipe: ${filteredRecipes[index].title}');
//                   },
//                   child: Card(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         Expanded(
//                           child: Image.network(
//                             filteredRecipes[index].imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             filteredRecipes[index].title,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             filteredRecipes[index].description,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final List<String> categories;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.categories,
  });
}

class RecipeGrid extends StatefulWidget {
  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  late List<Recipe> recipes;
  late List<Recipe> filteredRecipes;
  TextEditingController searchController = TextEditingController();
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // Fetch recipes when the page loads
  }

  // Temporary list of recipes for testing
  // void fetchRecipes() {
  //   setState(() {
  //     recipes = [
  //       Recipe(
  //         title: 'Recipe 1',
  //         description: 'Description for Recipe 1',
  //         imageUrl: 'https://via.placeholder.com/300',
  //         categories: ['Category A', 'Category B'],
  //       ),
  //       Recipe(
  //         title: 'Recipe 2',
  //         description: 'Description for Recipe 2',
  //         imageUrl: 'https://via.placeholder.com/300',
  //         categories: ['Category B', 'Category C'],
  //       ),
  //       Recipe(
  //         title: 'Recipe 3',
  //         description: 'Description for Recipe 3',
  //         imageUrl: 'https://via.placeholder.com/300',
  //         categories: ['Category A', 'Category C'],
  //       ),
  //       // Add more recipes as needed
  //     ];
  //     filteredRecipes = List.from(recipes);
  //   });
  // }


void fetchRecipes() async {
  try {
    var url = Uri.parse('http://localhost:5000/api/recipes/getAllRecipes');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        // Assuming the response structure matches the Recipe model
        recipes = List<Recipe>.from(data['recipes'].map((recipeJson) => Recipe(
          title: recipeJson['name'],
          description: recipeJson['description'],
          imageUrl: recipeJson['image'],
          categories: [recipeJson['category']],
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
          return selectedCategories.every((category) => recipe.categories.contains(category));
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
                    print('Clicked on recipe: ${filteredRecipes[index].title}');
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
      )
    //    bottomNavigationBar: BottomAppBar(
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         IconButton(
    //           onPressed: () {
    //             // Navigate to home page
    //           },
    //           icon: Icon(Icons.home),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             // Navigate to favorites page
    //           },
    //           icon: Icon(Icons.favorite),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             // Navigate to add recipe page
    //           },
    //           icon: Icon(Icons.add),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             // Navigate to logout page
    //           },
    //           icon: Icon(Icons.logout),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             // Navigate to user profile page
    //           },
    //           icon: Icon(Icons.person),
    //         ),
    //       ],
        );
    //   ),
    // );
    // );
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
                        .expand((recipe) => recipe.categories)
                        .toSet()
                        .map(
                          (category) => GestureDetector(
                            onTap: () {
                              setState(() {
                                toggleCategory(category);
                              });
                            },
                            child: Chip(
                              label: Text(category),
                              backgroundColor: selectedCategories.contains(category) ? Colors.orange : null,
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
