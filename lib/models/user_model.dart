// User class represents a user with a username and password.
class User {
  final String username; // The username of the user
  final String password; // The password of the user

  // Constructor for User class that requires username and password.
  User({required this.username, required this.password});

  // Factory method to create a User instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'], // Extract username from JSON
      password: json['password'], // Extract password from JSON
    );
  }
}
