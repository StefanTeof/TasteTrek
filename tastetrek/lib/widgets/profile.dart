import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tastetrek/utils/server_url.dart';

class ProfileWidget extends StatefulWidget {
  final String userId; // The user ID passed as a parameter

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
  List<dynamic> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final String? authToken = await _storage.read(key: 'auth_token');
    print(authToken);
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
        print("Response Data Profile: ${responseData}");
        setState(() {
          profileImageUrl = responseData['user']['profileImageUrl'];
          firstName = responseData['user']['firstName'];
          lastName = responseData['user']['lastName'];
          username = responseData['user']['username'];
          bio = responseData['user']['bio'];
          country = responseData['user']['country'];
          city = responseData['user']['city'];
          recipes = responseData['user']['recipes'] ?? [];
          recipeCount = recipes.length;
          isLoading = false;
        });
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
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeListScreen(recipes: recipes),
                    ),
                  );
                },
                child: Text(
                  'View Recipes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  final List<dynamic> recipes; // List of recipes

  const RecipeListScreen({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            child: ListTile(
              leading: Image.network(recipe['image']),
              title: Text(recipe['name']),
              subtitle: Text(recipe['description']),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Handle like button action
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
