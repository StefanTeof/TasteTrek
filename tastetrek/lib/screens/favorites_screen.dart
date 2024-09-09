import 'package:flutter/material.dart';
import 'package:tastetrek/widgets/footer.dart';
import 'package:tastetrek/widgets/header.dart';
import 'package:tastetrek/widgets/favorites.dart';


class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader(),
      body: FavoritesWidget(),
      bottomNavigationBar: MyAppFooter(),
    );
  }
}