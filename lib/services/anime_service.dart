import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimeService {
  static const String url = 'https://api.jikan.moe/v4';

  static Future<List<dynamic>> fetchTopAnimes() async {
    final response = await http.get(Uri.parse('$url/top/anime'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to fetch top animes');
    }
  }

  static Future<dynamic> searchAnime(String keyWord) async {
    final response = await http.get(Uri.parse('$url/anime?q=$keyWord'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to fetch the anime');
    }
  }
}
