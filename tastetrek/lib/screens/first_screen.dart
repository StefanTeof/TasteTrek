/* // lib/src/screens/home_screen.dart */

import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/recipes.dart';
import '../widgets/get_started.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: RecipeGrid(),
    );
  }
}