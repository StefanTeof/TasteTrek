import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';

class MyAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          '../assets/logo.png', // Corrected the asset path
          width: 140,
          fit: BoxFit.contain,
        ),
        actions: [
          GetBuilder<HeaderController>(
            init: HeaderController(),
            builder: (_) => Row(
              children: [
                GestureDetector(
                  onTap: _.toggleFavorite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: _.isFavorite.value ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('User Profile'),
                          onTap: () {
                            // Handle user profile tap
                            Navigator.pop(context); // Close the menu
                            // Implement the logic for the user profile
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onTap: () async {
                              // Handle logout tap
                              await _storage.delete(key: 'auth_token');
                              Navigator.pop(context); // Close the menu
                              // Navigate to the login screen using Navigator.push
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen()), // Assuming LoginScreen is your login screen
                              );
                              ;
                            }),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class HeaderController extends GetxController {
  RxBool isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.toggle();
  }
}