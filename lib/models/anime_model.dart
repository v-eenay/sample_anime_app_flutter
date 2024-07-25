class AnimeModel {
  final int id;
  final String title;
  final String englishTitle;
  final String synopsis;
  final int episodes;
  final double rating;
  final String source;
  final String status;
  final String imageUrl;
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
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        englishTitle: json['title_english'] ?? '',
        synopsis: json['synopsis'] ?? '',
        episodes: json['episodes'] ?? 0,
        imageUrl: json['images']['jpg']['large_image_url'] ?? '',
        rating: json['score'] ?? 0,
        source: json['source'] ?? '',
        status: json['status'] ?? '');
  }
}
