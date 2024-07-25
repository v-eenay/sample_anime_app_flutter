import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/anime_model.dart';

class AnimeDetails extends StatelessWidget {
  final AnimeModel animeModel;

  AnimeDetails({super.key, required this.animeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animeModel.title, style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(animeModel.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animeModel.title,
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${animeModel.englishTitle}\nEpisodes: ${animeModel.episodes}\nRating: ${animeModel.rating} / 10\nSource: ${animeModel.source}\nStatus: ${animeModel.status}',
                          style: GoogleFonts.lato(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width * 0.015
                                : MediaQuery.of(context).size.width * 0.03,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    animeModel.synopsis,
                    style: GoogleFonts.lato(
                      fontSize: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width * 0.015
                          : MediaQuery.of(context).size.width * 0.03,
                      color: Colors.black87,
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
