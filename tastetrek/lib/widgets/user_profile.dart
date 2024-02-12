import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:location/location.dart';


class UserProfileWidget extends StatefulWidget {
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();
  final Location _location = Location();
  
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String authToken;
  bool tokenRetrieved = false;
  XFile? profilePicture;

  @override
  void initState() {
    super.initState();
    _getAuthToken();
  }

  Future<void> _getAuthToken() async {
    // Retrieve the authorization token from Flutter Secure Storage
    authToken = await _storage.read(key: 'auth_token') ?? '';
    print("Authtoken: $authToken");

    setState(() {
      tokenRetrieved = true;
    });

    // Call _getUser only when the token is retrieved
    if (tokenRetrieved) {
      _getUser();
    }
  }

  Future<void> _getUser() async {
    final String url = 'http://localhost:5000/api/users/getUser';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final user = responseData['user'];

        setState(() {
          firstNameController.text = user['firstName'];
          lastNameController.text = user['lastName'];
          usernameController.text = user['username'];
          emailController.text = user['email'];
          locationController.text = user['location'] ?? '';
          // Exclude password, as it should not be displayed
        });
      } else {
        // Handle error
        print('Error: ${response.body}');
      }
    } catch (error) {
      // Handle network or server errors
      print('Error: $error');
    }
  }

  Future<void> _editUser() async {
    final String url = 'http://localhost:5000/api/users/editUser';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = authToken
        ..fields['username'] = usernameController.text
        ..fields['email'] = emailController.text
        ..files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture?.path ?? '',
        ))
        ..fields['location'] = locationController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(await response.stream.bytesToString());
        final user = responseData['user'];

        // Handle success, e.g., show a success message
        print('User updated successfully');
      } else {
        // Handle error
        print('Error: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      // Handle network or server errors
      print('Error: $error');
    }
  }

  Future<void> _pickProfilePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      profilePicture = pickedFile;
    });
  }

  Future<void> _pickLocation() async {
    try {
      LocationData currentLocation = await _location.getLocation();
      // Handle location data, for example, you can set the locationController
      // to the formatted address or coordinates as per your requirement.
      locationController.text = "${currentLocation.latitude}, ${currentLocation.longitude}";
    } catch (e) {
      // Handle location exception
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickProfilePicture,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: profilePicture != null ? FileImage(File(profilePicture!.path)) : null,
              child: profilePicture == null ? Icon(Icons.camera_alt, size: 50) : null,
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: _pickLocation,
                tooltip: 'Pick Location',
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _editUser();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 70.0, vertical: 25.0),
              ),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
