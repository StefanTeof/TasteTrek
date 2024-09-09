// utils/favorites.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'server_url.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

/// Reads the authorization token from secure storage
Future<String?> getAuthToken() async {
  return await _storage.read(key: 'auth_token');
}

/// Fetches the user's favorite recipes from the server
Future<List<dynamic>> fetchFavoriteRecipes(String authToken) async {
  final response = await http.get(
    Uri.parse('${getBaseUrl()}api/favorites/getFavoriteRecipes'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": authToken,
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
  } else {
    throw Exception('Failed to load favorite recipes');
  }
}

/// Toggles the favorite status of a recipe on the server
Future<void> toggleFavorite(String recipeId, String authToken, bool isCurrentlyFavorited) async {
  String endpoint = isCurrentlyFavorited
      ? 'removeRecipeFromFavorites'
      : 'addRecipeToFavorites';

  final response = await http.post(
    Uri.parse('${getBaseUrl()}api/favorites/$endpoint/$recipeId'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": authToken,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to toggle favorite status');
  }
}
