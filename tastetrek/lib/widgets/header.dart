import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';

class MyAppHeader extends StatelessWidget implements PreferredSizeWidget {

  final bool automaticallyImplyLeading;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  MyAppHeader({this.automaticallyImplyLeading = false});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo.png', // Corrected the asset path
          width: 140,
          fit: BoxFit.contain,
        ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class HeaderController extends GetxController {
  RxBool isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.toggle();
  }
}