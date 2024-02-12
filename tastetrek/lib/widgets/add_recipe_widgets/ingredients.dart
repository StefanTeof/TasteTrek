import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/instructions.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';

class IngredientsWidget extends StatefulWidget {
  final String name;
  final String description;
  final String category;

  IngredientsWidget({
    required this.name,
    required this.description,
    required this.category,
  });

  @override
  _IngredientsWidgetState createState() => _IngredientsWidgetState();
}

class _IngredientsWidgetState extends State<IngredientsWidget> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> _ingredientList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        Expanded(
          child: _buildIngredientList(),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _ingredientController,
                decoration: InputDecoration(
                  labelText: 'Add Ingredient',
                  hintText: 'Eg. flour, 200gr',
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {
                _addIngredient();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(bottom: 300.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                _proceedToNextScreen();
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
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
                ),
              ),
              child: Text('Next'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientList() {
    return ListView.builder(
      itemCount: _ingredientList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          '- ${_ingredientList[index]}',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _addIngredient() {
    String ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredientList.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _proceedToNextScreen() {
    // Pass data to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstructionsScreen(
          name: widget.name,
          description: widget.description,
          category: widget.category,
          ingredientList: _ingredientList,
        ),
      ),
    );
  }
}
