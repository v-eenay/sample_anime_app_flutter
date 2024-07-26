import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/anime_model.dart';

// AnimeDetails is a StatelessWidget that displays detailed information about an anime.
class AnimeDetails extends StatelessWidget {
  final AnimeModel animeModel; // AnimeModel instance containing anime data

  // Constructor for AnimeDetails that requires an AnimeModel instance.
  AnimeDetails({super.key, required this.animeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animeModel.title,
            style:
                GoogleFonts.poppins()), // Title of the AppBar with custom font
        centerTitle: true, // Center the title in the AppBar
        backgroundColor: Colors.white, // Background color of the AppBar
        foregroundColor: Colors.black, // Color of the title text
        elevation: 2, // Elevation for shadow effect
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.4, // Container height as a percentage of screen height
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.4, // Container width as a percentage of screen width
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            animeModel.imageUrl), // Display anime image
                        fit: BoxFit.cover, // Cover the container with the image
                      ),
                      borderRadius: BorderRadius.circular(
                          12), // Rounded corners for the container
                    ),
                  ),
                  const SizedBox(width: 16), // Space between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animeModel.title, // Anime title
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width *
                                    0.05, // Adjust font size based on screen width
                            fontWeight: FontWeight.bold, // Bold font weight
                          ),
                        ),
                        const SizedBox(
                            height:
                                8), // Space between title and additional info
                        Text(
                          '${animeModel.englishTitle}\nEpisodes: ${animeModel.episodes}\nRating: ${animeModel.rating} / 10\nSource: ${animeModel.source}\nStatus: ${animeModel.status}',
                          style: GoogleFonts.lato(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width * 0.015
                                : MediaQuery.of(context).size.width *
                                    0.03, // Adjust font size based on screen width
                            color: Colors.black54, // Text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Space between image/info and synopsis
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(
                      16.0), // Padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.grey[
                        100], // Background color of the synopsis container
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1, // Spread radius for the shadow
                        blurRadius: 5, // Blur radius for the shadow
                        offset: const Offset(0, 3), // Offset for the shadow
                      ),
                    ],
                  ),
                  child: Text(
                    animeModel.synopsis, // Anime synopsis
                    style: GoogleFonts.lato(
                      fontSize: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width * 0.015
                          : MediaQuery.of(context).size.width *
                              0.03, // Adjust font size based on screen width
                      color: Colors.black87, // Text color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
