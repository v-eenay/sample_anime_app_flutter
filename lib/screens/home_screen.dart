import 'package:flutter/material.dart';

import '../models/anime_model.dart';
import '../services/anime_service.dart';
import 'anime_details.dart';

// HomePage is a StatefulWidget that displays a list of anime and handles searching.
class HomePage extends StatefulWidget {
  final VoidCallback onLogout; // Callback function to handle user logout
  final String username; // Username of the logged-in user

  // Constructor for HomePage that requires onLogout and username parameters.
  const HomePage({super.key, required this.onLogout, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

// _HomePageState manages the state of HomePage.
class _HomePageState extends State<HomePage> {
  late Future<List<AnimeModel>>
      animeList; // Future to store the list of top animes
  late Future<List<AnimeModel>> searchResults; // Future to store search results
  bool _isSearching = false; // Flag to indicate if a search is active
  final TextEditingController _searchController =
      TextEditingController(); // Controller for search input

  @override
  void initState() {
    super.initState();
    _loadTopAnimes(); // Load top animes when the widget is initialized
  }

  // Loads the top animes from the AnimeService
  void _loadTopAnimes() {
    animeList = AnimeService.fetchTopAnimes().then((data) {
      return data
          .map((json) => AnimeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  // Searches for animes based on the provided query
  void _searchAnime(String query) async {
    try {
      var results = await AnimeService.searchAnime(query);
      setState(() {
        searchResults = Future.value(results
            .map((json) => AnimeModel.fromJson(json as Map<String, dynamic>))
            .toList());
        _isSearching = true; // Set the searching flag to true
      });
    } catch (e) {
      print('Error: $e'); // Print any error that occurs during search
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime App'), // Title of the AppBar
        centerTitle: true, // Center the title in the AppBar
        actions: [
          _buildSearchField(), // Build the search input field
          IconButton(
            icon: Icon(Icons.logout), // Logout button icon
            onPressed: widget.onLogout, // Call the logout callback
          )
        ],

        // Display username if logged in
        flexibleSpace: widget.username.isNotEmpty
            ? Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    'Hello, ${widget.username}', // Display welcome message with username
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.width * 0.015
                            : MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
              )
            : null,
      ),
      body: _buildBody(), // Build the body of the screen
    );
  }

  // Builds the search input field
  Widget _buildSearchField() {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.35, // Adjust width based on screen size
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: _searchController, // Controller for managing search input
        onSubmitted: _searchAnime, // Trigger search when input is submitted
        decoration: InputDecoration(
          hintText: 'Search', // Placeholder text in the search field
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8), // Rounded corners for the border
          ),
        ),
      ),
    );
  }

  // Builds the body of the screen based on search status and data availability
  Widget _buildBody() {
    return FutureBuilder<List<AnimeModel>>(
      future: _isSearching
          ? searchResults
          : animeList, // Use search results if searching
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Show a loading spinner while data is being fetched
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Error: ${snapshot.error}')); // Show error message if something goes wrong
        } else if (snapshot.hasData) {
          return _buildGridView(
              snapshot.data!); // Build grid view with anime data
        } else {
          return Center(
              child: Text(
                  'No Data Available')); // Show message if no data is available
        }
      },
    );
  }

  // Builds a grid view to display anime items
  Widget _buildGridView(List<AnimeModel> animeModels) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600
            ? 4
            : 2, // Number of columns based on screen width
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65, // Aspect ratio of the child items
      ),
      itemCount: animeModels.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return _buildAnimeCard(
            animeModels[index]); // Build a card for each anime item
      },
    );
  }

  // Builds a card to display individual anime details
  Widget _buildAnimeCard(AnimeModel animeModel) {
    final isLargeScreen =
        MediaQuery.of(context).size.width > 600; // Check if the screen is large
    final screenWidth = isLargeScreen
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.8;
    final titleFontSize = screenWidth * 0.04; // Font size for the title
    final synopsisFontSize = screenWidth * 0.03; // Font size for the synopsis

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetails(
                animeModel: animeModel), // Navigate to AnimeDetails page
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                animeModel.imageUrl, // Display anime image
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animeModel.title, // Display anime title
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize, // Font size for the title
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      animeModel.synopsis, // Display anime synopsis
                      maxLines: isLargeScreen ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize:
                            synopsisFontSize, // Font size for the synopsis
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
