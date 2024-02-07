import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40), // Custom height for the app bar
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          width: 140,
          '../../assets/logo.png',
          fit: BoxFit.contain,
        ),
        actions: [
          GetBuilder<HeaderController>(
            init: HeaderController(),
            builder: (_) => GestureDetector(
              onTap: _.toggleFavorite, // Toggle favorite on tap
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.favorite_border, // Use the outline heart icon
                  color: _.isFavorite.value ? Colors.red : Colors.black, // Change color based on state
                  // Apply border directly to the icon
                  // border: Border.all(
                  //   color: _.isFavorite.value ? Colors.red : Colors.black,
                  //   width: 2, // Adjust the thickness of the border as needed
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40); // Same custom height
}


class HeaderController extends GetxController {
  RxBool isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.toggle(); // Toggle favorite state
  }
}
