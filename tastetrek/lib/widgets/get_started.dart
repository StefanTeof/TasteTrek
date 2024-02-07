import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/first_screen.dart';
import '../screens/login_screen.dart';
import '../screens/recipes_screen.dart';

class GetstartedWidget extends StatefulWidget {
  @override
  _GetstartedWidgetState createState() => _GetstartedWidgetState();
}

class _GetstartedWidgetState extends State<GetstartedWidget> {
  
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(context);
  }

  Future<void> _checkLoginStatus(BuildContext context) async {
    final String? authToken = await _storage.read(key: 'auth_token');
    
    if (authToken != null && authToken.isNotEmpty) {
      // User is already logged in, navigate to RecipesScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecipesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  '../assets/tastetrek_logo_transparent.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Button press callback
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 70.0, vertical: 25.0),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
