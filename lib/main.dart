import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

// The entry point of the Flutter application.
void main() {
  runApp(MyApp()); // Runs the MyApp widget.
}

// MyApp is the main widget of the application.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// _MyAppState manages the state of MyApp.
class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false; // Tracks whether the user is logged in or not.
  String _username = ''; // Stores the username of the logged-in user.

  // Method to handle user login.
  void _login(String username) {
    setState(() {
      _isLoggedIn = true; // Updates login status to true.
      _username = username; // Stores the username.
    });
  }

  // Method to handle user logout.
  void _logout() {
    setState(() {
      _isLoggedIn = false; // Updates login status to false.
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner.
      title: 'Anime App', // Title of the app.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color of the app.
        brightness: Brightness.light, // Light theme.
        textTheme:
            GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          titleLarge: GoogleFonts.poppins(
            // Title text styling.
            fontSize: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width *
                    0.02 // Size for larger screens.
                : MediaQuery.of(context).size.width *
                    0.05, // Size for smaller screens.
            fontWeight: FontWeight.bold, // Bold text.
          ),
          bodyMedium: GoogleFonts.lato(
            // Body text styling.
            fontSize: MediaQuery.of(context).size.width *
                0.015, // Font size for body text.
            color: Colors.black87, // Text color.
          ),
        ),
        appBarTheme: AppBarTheme(
          // AppBar styling.
          backgroundColor: Colors.white, // AppBar background color.
          foregroundColor: Colors.black, // AppBar text and icon color.
          elevation: 1, // Shadow below the AppBar.
          iconTheme:
              IconThemeData(color: Colors.black), // Icon color in AppBar.
        ),
        cardTheme: CardTheme(
          // Card styling.
          color: Colors.white, // Card background color.
          elevation: 4, // Shadow below the Card.
          margin: EdgeInsets.all(8), // Margin around the Card.
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // Rounded corners for the Card.
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // Input field styling.
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8), // Rounded corners for input fields.
          ),
          hintStyle: GoogleFonts.lato(
            // Hint text styling.
            fontSize: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width *
                    0.015 // Size for larger screens.
                : MediaQuery.of(context).size.width *
                    0.04, // Size for smaller screens.
            color: Colors.black38, // Hint text color.
          ),
          prefixIconColor:
              Colors.black54, // Color for icons inside input fields.
        ),
      ),
      home: _isLoggedIn
          ? HomePage(
              onLogout: _logout,
              username: _username) // Shows HomePage if logged in.
          : LoginPage(onLogin: _login), // Shows LoginPage if not logged in.
    );
  }
}
