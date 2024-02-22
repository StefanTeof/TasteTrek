import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/nextscreen.dart';
import 'package:tastetrek/widgets/add_recipe_widgets/name_description.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/screens/add_recipe_screens/ingredients.dart';

class RecipeNameInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: RecipeInfoInputWidget(
        onNextPressed: (formData) {},
      ),
    );
  }
}
