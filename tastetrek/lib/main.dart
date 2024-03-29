import 'package:flutter/material.dart';
import 'package:tastetrek/screens/add_recipe_screens/success_screen.dart';
import 'screens/register_screen.dart';
import 'package:tastetrek/widgets/questions.dart';
import 'package:tastetrek/widgets/recipes.dart';
import 'screens/first_screen.dart';
import 'screens/login_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: FirstScreen(),
//     );
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Page Example',
      home: FirstScreen(),
    );
  }
}
