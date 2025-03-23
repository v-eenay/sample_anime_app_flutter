# Flutter Anime App

This Flutter project is designed for beginners and students to learn Flutter development. It includes a basic app that demonstrates how to implement a dummy login system and interact with external APIs.

## Project Overview

The Anime App showcases:

- A dummy login system using a JSON file for authentication.
- Integration with the Jikan API to fetch and display anime data.
- Basic navigation and UI elements to help students understand Flutter's core concepts.

## Features

- **Dummy Login System**: Implemented using a JSON file (assets/users.json). This is a placeholder and not connected to an actual database. Students are encouraged to replace this with their backend API for a real authentication system.
- **Anime Data Fetching:** Retrieves top anime data and search results from the Jikan API.
- **Responsive Design:** Adaptable to different screen sizes for improved user experience.

## Getting Started

### Prerequisites

- Flutter SDK (2.0.0 or higher)
- Dart (2.12.0 or higher)
- A code editor like Visual Studio Code or Android Studio

### Installation

1. Clone the repository:
   `git clone https://github.com/v-eenay/flutter-anime-app.git
2. Navigate to the project directory:
   `cd flutter-anime-app`
3. Install the dependencies:
   `flutter pub get`
4. Add your own users.json file to the assets folder. Make sure the structure of the JSON file matches the expected format.
5. Run the app:
   `flutter run`

### Usage

- **Login Page:** Enter your username and password. The login will be validated against the users.json file.
- **Home Page:** After a successful login, you will be able to view the top anime list and search for anime.

### Customization

- **Authentication:** Replace the dummy login logic with your backend API to implement real authentication.
- **Anime Data:** Modify the API endpoints and data handling according to your requirements.

### Code Structure

- lib/main.dart: Entry point of the application.
- lib/services/auth_service.dart: Handles authentication logic.
- lib/services/anime_service.dart: Manages fetching anime data from the API.
- lib/models/user_model.dart: Defines the user model.
- lib/models/anime_model.dart: Defines the anime model.
- lib/screens/login_screen.dart: UI for login.
- lib/screens/home_screen.dart: Main screen displaying anime data.
- lib/screens/anime_details.dart: Detailed view of a selected anime.

### License

All rights reserved © Vinay Koirala.

### Contributing

Feel free to fork the repository and submit pull requests. For major changes or features, please open an issue first to discuss your proposed changes.
