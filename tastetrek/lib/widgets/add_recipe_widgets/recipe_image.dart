import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SubmitRecipeWidget extends StatefulWidget {
  final String name;
  final String description;
  final String category;
  final List<String> ingredientList;
  final String instructions;
  final String calories;
  final String carbs;
  final String fats;
  final String proteins;

  SubmitRecipeWidget({
    required this.name,
    required this.description,
    required this.category,
    required this.ingredientList,
    required this.instructions,
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.proteins,
  });

  @override
  _SubmitRecipeWidgetState createState() => _SubmitRecipeWidgetState();
}

class _SubmitRecipeWidgetState extends State<SubmitRecipeWidget> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Recipe Image:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        _selectedImage != null
            ? Image.file(
                File(_selectedImage!.path),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              )
            : Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _pickImage();
          },
          child: Text('Choose Image'),
        ),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(bottom: 300.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                _submitRecipe();
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
              child: Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }

  void _pickImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  void _submitRecipe() async {
    // Prepare the data for the multi-part form data request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5000/api/recipes/addRecipe'),
    );

    request.fields['name'] = widget.name;
    request.fields['description'] = widget.description;
    request.fields['category'] = widget.category;
    request.fields['ingredientList'] = widget.ingredientList.join(',');
    request.fields['instructions'] = widget.instructions;
    request.fields['calories'] = widget.calories;
    request.fields['carbs'] = widget.carbs;
    request.fields['fats'] = widget.fats;
    request.fields['proteins'] = widget.proteins;


    if (_selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _selectedImage!.path,
        ),
      );
    }

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Successfully submitted, handle the response
        print('Recipe submitted successfully!');
        // TODO: Navigate to success screen
      } else {
        // Handle the error response
        print('Failed to submit recipe. Status code: ${response.statusCode}');
        // Handle the error, show a message or retry
      }
    } catch (error) {
      // Handle the exception
      print('Error submitting recipe: $error');
    }
  }
}
