import 'dart:convert';
import 'package:http/http.dart' as http;

// AnimeService handles API requests related to anime.
class AnimeService {
  // Base URL for the Jikan API (a popular API for anime data).
  static const String url = 'https://api.jikan.moe/v4';

  // Fetches a list of top animes from the API.
  static Future<List<dynamic>> fetchTopAnimes() async {
    // Send a GET request to the top animes endpoint.
    final response = await http.get(Uri.parse('$url/top/anime'));

    // Check if the request was successful (status code 200).
    if (response.statusCode == 200) {
      // Decode the JSON response.
      final jsonResponse = json.decode(response.body);
      // Return the 'data' part of the JSON response, which contains the list of top animes.
      return jsonResponse['data'];
    } else {
      // Throw an exception if the request failed.
      throw Exception('Failed to fetch top animes');
    }
  }

  // Searches for an anime based on the provided keyword.
  static Future<dynamic> searchAnime(String keyWord) async {
    // Send a GET request to the search endpoint with the keyword as a query parameter.
    final response = await http.get(Uri.parse('$url/anime?q=$keyWord'));

    // Check if the request was successful (status code 200).
    if (response.statusCode == 200) {
      // Decode the JSON response.
      final jsonResponse = json.decode(response.body);
      // Return the 'data' part of the JSON response, which contains the search results.
      return jsonResponse['data'];
    } else {
      // Throw an exception if the request failed.
      throw Exception('Failed to fetch the anime');
    }
  }
}
