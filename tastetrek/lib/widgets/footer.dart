import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tastetrek/screens/add_recipe_screens/name_description.dart';
import 'package:tastetrek/screens/recipes_screen.dart';
import 'package:tastetrek/screens/user_profile_screen.dart';

import '../screens/login_screen.dart';

class MyAppFooter extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
@override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              // Navigate to home page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesScreen(),
                ),
              );
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              // Navigate to favorites page
            },
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              // Navigate to add recipe page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeNameInputScreen(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              // Navigate to logout page
              await _logout(context);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              // Navigate to user profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(),
                ),
              );

            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'auth_token');


    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
