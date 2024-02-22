import 'package:flutter/material.dart';
import 'package:tastetrek/screens/recipes_screen.dart';
import 'package:tastetrek/widgets/header.dart';

class SuccessAddRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You added a new recipe!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipesScreen()
                    ));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
                ),
              ),
              child: Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
