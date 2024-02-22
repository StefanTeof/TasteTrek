import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';
import 'package:tastetrek/screens/add_recipe_screens/nutrition.dart';

class InstructionsWidget extends StatefulWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;

  InstructionsWidget({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList
  });

  @override
  _InstructionsWidgetState createState() => _InstructionsWidgetState();
}

class _InstructionsWidgetState extends State<InstructionsWidget> {
  final TextEditingController _instructionController = TextEditingController();
  String _instructions = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        Expanded(
          child: _buildInstructionsText(),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _instructionController,
                maxLines: null, // Allow multiple lines
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Add Instruction',
                  hintText: 'Step 1: ...',
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {
                _addInstruction();
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
              child: Text('Next'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsText() {
    return SingleChildScrollView(
      child: Text(
        _instructions,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void _addInstruction() {
    String instruction = _instructionController.text.trim();
    if (instruction.isNotEmpty) {
      setState(() {
        _instructions += (instruction + '\n');
        _instructionController.clear();
      });
    }
  }

  void _proceedToNextScreen() {
  if (_instructions.trim().isNotEmpty) {
    // If instructions have been added, proceed to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NutritionScreen(
          name: widget.name,
          description: widget.description,
          category: widget.category,
          ingredientList: widget.ingredientList,
          instructions: _instructions,
        ),
      ),
    );
  } else {
    // If no instructions have been added, show a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please add at least one instruction'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
}
