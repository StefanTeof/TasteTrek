import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/login_screen.dart';
import 'dart:convert';
import '../screens/recipes_screen.dart'; // Import the RecipesScreen

class RegisterFormWidget extends StatelessWidget {
  Future<void> _registerUser(BuildContext context, String firstName,
      String lastName, String email, String username, String password) async {
    final String url = 'http://localhost:5000/api/users/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful registration, navigate to RecipesScreen
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

  @override
  Widget build(BuildContext context) {
    String firstName = "";
    String lastName = "";
    String username = "";
    String email = "";
    String password = "";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
                      child: TextField(
                        onChanged: (value) {
                          firstName = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 10.0),
                      child: TextField(
                        onChanged: (value) {
                          lastName = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the LoginScreen when the "Login" link is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
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
                  // Call the _registerUser function on button press
                  _registerUser(
                      context, firstName, lastName, email, username, password);
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
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
