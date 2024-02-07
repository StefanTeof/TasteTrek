import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../screens/recipes_screen.dart';
import '../screens/register_screen.dart';

class LoginFormWidget extends StatelessWidget {
  
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> _loginUser(BuildContext context, String username, String password) async {
    final String url = 'http://localhost:5000/api/users/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful registration, navigate to RecipesScreen
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        await _saveTokenToSecureStorage(token);
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesScreen()),
        );
      } else {
        // Unsuccessful registration, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.body}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      // Handle any network or server errors
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred during registration.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _saveTokenToSecureStorage(String token) async {
    await _storage.write(key: 'auth_token', value: token);
    print('Token saved to Flutter Secure Storage: $token');
  }

  @override
  Widget build(BuildContext context) {

    String username = "";
    String  password = "";

    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 200.0),
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:  TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle register link tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Login button press callback
                  _loginUser(
                      context, username, password);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 70.0, vertical: 25.0),
                  ),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Future<void> _saveTokenToSharedPreferences(String token) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('auth_token', token);

// }