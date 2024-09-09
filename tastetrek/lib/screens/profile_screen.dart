import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/footer.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/profile.dart'; 

class ProfileScreen extends StatelessWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(automaticallyImplyLeading: true),
      body: ProfileWidget(userId: userId), 
      bottomNavigationBar: MyAppFooter(), 
    );
  }
}
