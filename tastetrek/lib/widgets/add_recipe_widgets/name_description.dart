import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/ingredients.dart';
// Ensure you have an IngredientsScreen widget defined in the appropriate file

class RecipeInfoInputWidget extends StatefulWidget {
  final Function(Map<String, dynamic>)? onNextPressed;

  RecipeInfoInputWidget({this.onNextPressed});

  @override
  _RecipeInfoInputWidgetState createState() => _RecipeInfoInputWidgetState();
}

class _RecipeInfoInputWidgetState extends State<RecipeInfoInputWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Any'; // Default category to 'Any'
  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Appetizers', 'Entrees', 'Sides', 'Desserts', 'Beverages', 'Any']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // All fields are valid, proceed with the logic
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                  if (widget.onNextPressed != null) {
                    widget.onNextPressed!({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'category': _selectedCategory,
                    });
                  }
                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngredientsScreen(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        category: _selectedCategory,
                      ),
                    ),
                  );
                } else {
                  // If the form is not valid, show a snackbar or dialog
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
                ),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
