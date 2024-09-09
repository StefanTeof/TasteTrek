import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tastetrek/utils/server_url.dart';

class ProfileWidget extends StatefulWidget {
  final String userId;

  const ProfileWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? username;
  String? bio;
  String? country;
  String? city;
  int recipeCount = 0;
  List<Map<String, dynamic>> recipes = [];
  bool isLoading = true;
  Map<String, bool> favoriteStatuses = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final String? authToken = await _storage.read(key: 'auth_token');
    if (authToken == null) {
      print('Error: Authorization token is missing');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('${getBaseUrl()}api/users/getUserWithRecipes/${widget.userId}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          profileImageUrl = responseData['user']['profileImageUrl'];
          firstName = responseData['user']['firstName'];
          lastName = responseData['user']['lastName'];
          username = responseData['user']['username'];
          bio = responseData['user']['bio'];
          country = responseData['user']['country'];
          city = responseData['user']['city'];
          recipes = List<Map<String, dynamic>>.from(responseData['user']['recipes'] ?? []);
          recipeCount = recipes.length;
        });

        // After loading user data, fetch favorite recipes
        await getFavoriteRecipes();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getFavoriteRecipes() async {
    final String? authToken = await _storage.read(key: 'auth_token');
    if (authToken == null) {
      print('Error: Authorization token is missing');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('${getBaseUrl()}api/favorites/getFavoriteRecipes'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken,
        },
      );

      if (response.statusCode == 200) {
        final favoriteRecipes = json.decode(response.body)['favorites'];

        print("Favorite Recipes: ${favoriteRecipes}");

        setState(() {
          // Reset favoriteStatuses
          favoriteStatuses.clear();

          final List<String> favoriteIds = favoriteRecipes.map<String>((recipe) => recipe['_id'].toString()).toList();

          // Update favoriteStatuses based on the user's favorite recipes
          for (var recipe in recipes) {
            favoriteStatuses[recipe['_id']] = favoriteIds.contains(recipe['_id']);
          }
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load favorite recipes');
      }
    } catch (e) {
      print('Error fetching favorite recipes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toggleFavoriteStatus(String recipeId) async {
    final String? authToken = await _storage.read(key: 'auth_token');
    if (authToken == null) {
      print('Error: Authorization token is missing');
      return;
    }
    bool isCurrentlyFavorited = favoriteStatuses[recipeId] ?? false;
    String endpoint = isCurrentlyFavorited
        ? 'removeRecipeFromFavorites'
        : 'addRecipeToFavorites';

    try {
      final response = await http.post(
        Uri.parse('${getBaseUrl()}api/favorites/$endpoint/$recipeId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          favoriteStatuses[recipeId] = !isCurrentlyFavorited;
        });
      } else {
        throw Exception('Failed to toggle favorite status');
      }
    } catch (e) {
      print('Error toggling favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                      ? NetworkImage(profileImageUrl!)
                      : AssetImage('assets/account.png') as ImageProvider,
                  backgroundColor: Colors.grey.shade200,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${firstName ?? ''} ${lastName ?? ''}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@${username ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      bio ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${city ?? ''}, ${country ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange.shade100,
                child: Text(
                  '$recipeCount',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                final isFavorited = favoriteStatuses[recipe['_id']] ?? false;
                return Card(
                  child: ListTile(
                    leading: recipe['image'] != null && recipe['image'].isNotEmpty
                        ? Image.network(recipe['image'])
                        : Icon(Icons.image_not_supported),
                    title: Text(recipe['name'] ?? ''),
                    subtitle: Text(recipe['description'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        toggleFavoriteStatus(recipe['_id']);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
