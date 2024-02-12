import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/ingredients.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';

class RecipeInfoInputWidget extends StatefulWidget {
  final Function(Map<String, dynamic>)? onNextPressed;

  RecipeInfoInputWidget({this.onNextPressed});

  @override
  _RecipeInfoInputWidgetState createState() => _RecipeInfoInputWidgetState();
}

class _RecipeInfoInputWidgetState extends State<RecipeInfoInputWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Any'; // Default category

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }
              },
              items: [
                'Appetizers',
                'Entrees',
                'Sides',
                'Desserts',
                'Beverages',
                'Any'
              ]
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.only(top: 50.0), // Use padding for the button
            child: ElevatedButton(
              onPressed: () {
                if (widget.onNextPressed != null) {
                  widget.onNextPressed!({
                    'name': _nameController.text,
                    'description': _descriptionController.text,
                    'category': _selectedCategory,
                  });
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
                }
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
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
