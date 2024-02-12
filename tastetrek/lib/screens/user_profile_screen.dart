import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/user_profile.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: UserProfileWidget()
    );
  }
}