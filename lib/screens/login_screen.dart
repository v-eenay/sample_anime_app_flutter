import 'package:flutter/material.dart';
import 'package:anime_app/services/auth_service.dart';

// LoginPage is a StatefulWidget that handles user login.
class LoginPage extends StatefulWidget {
  final Function(String)
      onLogin; // Callback function to pass username on successful login

  // Constructor for LoginPage that requires the onLogin callback.
  const LoginPage({Key? key, required this.onLogin}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// _LoginPageState manages the state of LoginPage.
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService =
      AuthService(); // Instance of AuthService to handle authentication
  String _message = ''; // Stores any message to be displayed to the user

  // Handles login process when the user presses the login button.
  void _login() async {
    final username =
        _usernameController.text; // Get username from the controller
    final password =
        _passwordController.text; // Get password from the controller

    // Authenticate the user using AuthService
    final isAuthenticated = await _authService.authenticate(username, password);

    if (isAuthenticated) {
      // If authentication is successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );
      await Future.delayed(
          Duration(seconds: 1)); // Delay to allow the user to see the message

      // Show a dialog to welcome the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Welcome'), // Title of the dialog
            content: Text('Welcome $username'), // Content of the dialog
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  widget.onLogin(
                      username); // Pass the username to the parent widget
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // If authentication fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the screen width is small
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Title of the AppBar
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: EdgeInsets.all(
            isSmallScreen ? 8.0 : 16.0), // Adjust padding based on screen size
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center widgets vertically
          children: [
            TextField(
              controller: _usernameController, // Controller for username input
              decoration: InputDecoration(
                labelText: 'Username', // Label for the username input field
                border:
                    OutlineInputBorder(), // Border style for the input field
              ),
            ),
            SizedBox(
                height:
                    isSmallScreen ? 8.0 : 16.0), // Spacing between input fields
            TextField(
              controller: _passwordController, // Controller for password input
              decoration: InputDecoration(
                labelText: 'Password', // Label for the password input field
                border:
                    OutlineInputBorder(), // Border style for the input field
              ),
              obscureText: true, // Hide the text for the password input field
            ),
            SizedBox(
                height: isSmallScreen
                    ? 8.0
                    : 16.0), // Spacing between input fields and button
            ElevatedButton(
              onPressed: _login, // Trigger login when pressed
              child: Text('Login'), // Text for the button
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Text color of the button
                backgroundColor: Colors.blue, // Background color of the button
                elevation: 0, // No shadow for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Rounded corners for the button
                ),
              ),
            ),
            SizedBox(
                height: isSmallScreen
                    ? 8.0
                    : 16.0), // Spacing between button and message
            Text(_message), // Display message
          ],
        ),
      ),
    );
  }
}
