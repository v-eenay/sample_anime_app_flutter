import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/anime_model.dart';
import 'screens/anime_details.dart';
import 'services/anime_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        textTheme:
            GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          titleLarge: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.02
                : MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: MediaQuery.of(context).size.width * 0.015,
            color: Colors.black87,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: GoogleFonts.lato(
            fontSize: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.015
                : MediaQuery.of(context).size.width * 0.04,
            color: Colors.black38,
          ),
          prefixIconColor: Colors.black54,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<AnimeModel>> animeList;
  late Future<List<AnimeModel>> searchResults;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTopAnimes();
  }

  void _loadTopAnimes() {
    animeList = AnimeService.fetchTopAnimes().then((data) {
      List<AnimeModel> animeList = [];
      for (var json in data) {
        animeList.add(AnimeModel.fromJson(json as Map<String, dynamic>));
      }
      return animeList;
    });
  }

  void _searchAnime(String query) async {
    try {
      var results = await AnimeService.searchAnime(query);
      List<AnimeModel> animeResults = [];
      for (var json in results) {
        animeResults.add(AnimeModel.fromJson(json as Map<String, dynamic>));
      }
      setState(() {
        searchResults = Future.value(animeResults);
        _isSearching = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handleSearch(String query) {
    _searchAnime(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime App'),
        centerTitle: true,
        actions: [
          _buildSearchField(),
        ],
        leading: Icon(Icons.movie),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: _searchController,
        onSubmitted: _handleSearch,
        decoration: InputDecoration(
          hintText: 'Search',
        ),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<AnimeModel>>(
      future: _isSearching ? searchResults : animeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return _buildGridView(snapshot.data!);
        } else {
          return Center(child: Text('No Data Available'));
        }
      },
    );
  }

  Widget _buildGridView(List<AnimeModel> animeModels) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemCount: animeModels.length,
      itemBuilder: (context, index) {
        return _buildAnimeCard(animeModels[index]);
      },
    );
  }

  Widget _buildAnimeCard(AnimeModel animeModel) {
    final screenWidth = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.8;
    final titleFontSize = screenWidth * 0.04;
    final synopsisFontSize = screenWidth * 0.03;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetails(
              animeModel: animeModel,
            ),
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
                animeModel.imageUrl,
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
                      animeModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      animeModel.synopsis,
                      maxLines: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: synopsisFontSize,
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
