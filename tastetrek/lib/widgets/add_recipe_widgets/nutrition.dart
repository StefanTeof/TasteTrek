import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';
import 'package:tastetrek/screens/add_recipe_screens/recipe_image.dart';

class NutritionInfoWidget extends StatefulWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;

  NutritionInfoWidget({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList,
    required this.instructions,
  });

  @override
  _NutritionInfoWidgetState createState() => _NutritionInfoWidgetState();
}

class _NutritionInfoWidgetState extends State<NutritionInfoWidget> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0) - MediaQuery.of(context).padding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition Information:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            _buildNutritionForm(),
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
        ),
      ),
    );
  }

  Widget _buildNutritionForm() {
    return Column(
      children: [
        TextFormField(
          controller: _caloriesController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Calories per 100gr',
            hintText: 'Enter calories',
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _carbsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Carbs per 100gr',
            hintText: 'Enter carbs',
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _fatsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Fats per 100gr',
            hintText: 'Enter fats',
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _proteinsController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Proteins per 100gr',
            hintText: 'Enter proteins',
          ),
        ),
      ],
    );
  }

  void _proceedToNextScreen() {
    // Pass data to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeImageScreen(
          name: widget.name,
          description: widget.description,
          category: widget.category,
          ingredientList: widget.ingredientList,
          instructions: widget.instructions,
          calories: _caloriesController.text,
          carbs: _carbsController.text,
          fats: _fatsController.text,
          proteins: _proteinsController.text,
        ),
      ),
    );
  }
}
