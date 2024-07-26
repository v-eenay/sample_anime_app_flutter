import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

// AuthService handles authentication-related operations.
class AuthService {
  // Loads a list of users from a JSON file.
  Future<List<User>> loadUsers() async {
    // Load the JSON file as a string from the assets.
    final String response = await rootBundle.loadString('assets/users.json');

    // Decode the JSON string into a List of dynamic objects.
    final List<dynamic> data = jsonDecode(response);

    // Create an empty list to store User objects.
    List<User> users = [];

    // Iterate over each JSON object and convert it into a User object.
    for (var json in data) {
      User user = User.fromJson(json); // Convert JSON to User.
      users.add(user); // Add User to the list.
    }

    // Return the list of users.
    return users;
  }

  // Authenticate a user based on username and password.
  Future<bool> authenticate(String username, String password) async {
    // Load the list of users from the JSON file.
    final users = await loadUsers();

    // Iterate over each user to check if the username and password match.
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true; // Return true if credentials are correct.
      }
    }

    // Return false if no match is found.
    return false;
  }
}
