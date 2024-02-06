import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          '../assets/tastetrek_logo_transparent.png',
          width: 250,
          height: 300,
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: LoginFormWidget(),
      ),
    );
  }
}
