// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';

// import '../screens/login_screen.dart';

// class MyAppFooter extends StatelessWidget  {

//   @override
//   Widget build(BuildContext context) {
//     return  bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               onPressed: () {
//                 // Navigate to home page
//               },
//               icon: Icon(Icons.home),
//             ),
//             IconButton(
//               onPressed: () {
//                 // Navigate to favorites page
//               },
//               icon: Icon(Icons.favorite),
//             ),
//             IconButton(
//               onPressed: () {
//                 // Navigate to add recipe page
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 // Navigate to logout page
//               },
//               icon: Icon(Icons.logout),
//             ),
//             IconButton(
//               onPressed: () {
//                 // Navigate to user profile page
//               },
//               icon: Icon(Icons.person),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';

class MyAppFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              // Navigate to home page
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              // Navigate to favorites page
            },
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              // Navigate to add recipe page
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              // Navigate to logout page
              await _logout(context);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              // Navigate to user profile page
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Perform logout actions here
    // For example, clear user authentication tokens or session data

    // After logging out, navigate to the login screen
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
