import 'dart:io';  // For Platform checks

String getBaseUrl() {
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:5000/'; // Android Emulator uses 10.0.2.2 for localhost
  }

  // For all other platforms, return localhost
  return 'http://localhost:5000/';
}