// AnimeModel class represents the details of an anime.
class AnimeModel {
  final int id; // Unique identifier for the anime
  final String title; // Title of the anime
  final String englishTitle; // English title of the anime
  final String synopsis; // Brief description or summary of the anime
  final int episodes; // Number of episodes in the anime
  final double rating; // Rating of the anime (out of 10)
  final String source; // Source of the anime (e.g., manga, light novel)
  final String status; // Current status of the anime (e.g., airing, completed)
  final String imageUrl; // URL of the anime's image

  // Constructor for AnimeModel class that requires all properties.
  AnimeModel({
    required this.id,
    required this.title,
    required this.englishTitle,
    required this.synopsis,
    required this.episodes,
    required this.imageUrl,
    required this.rating,
    required this.source,
    required this.status,
  });

  // Factory method to create an AnimeModel instance from a JSON map.
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['id'] ?? 0, // Extracts id from JSON or defaults to 0 if missing
      title: json['title'] ??
          '', // Extracts title from JSON or defaults to an empty string if missing
      englishTitle: json['title_english'] ??
          '', // Extracts English title from JSON or defaults to an empty string if missing
      synopsis: json['synopsis'] ??
          '', // Extracts synopsis from JSON or defaults to an empty string if missing
      episodes: json['episodes'] ??
          0, // Extracts number of episodes from JSON or defaults to 0 if missing
      imageUrl: json['images']['jpg']['large_image_url'] ??
          '', // Extracts image URL from JSON or defaults to an empty string if missing
      rating: json['score']?.toDouble() ??
          0.0, // Extracts rating from JSON and converts to double, defaults to 0.0 if missing
      source: json['source'] ??
          '', // Extracts source from JSON or defaults to an empty string if missing
      status: json['status'] ??
          '', // Extracts status from JSON or defaults to an empty string if missing
    );
  }
}
