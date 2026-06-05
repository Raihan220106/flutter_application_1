import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetPlaygroundApp());
}

class WidgetPlaygroundApp extends StatelessWidget {
  const WidgetPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE8E8ED),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE8E8ED),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const MovieCatalogPage(),
    );
  }
}

class MovieCatalogPage extends StatelessWidget {
  const MovieCatalogPage({super.key});

  static const List<MovieItem> _movies = [
    MovieItem(
      title: 'Sakamoto Days',
      date: '2025-01-11',
      rating: '7.6',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1026/146459l.jpg',
    ),
    MovieItem(
      title: 'One Piece',
      date: '1999-10-20',
      rating: '8.7',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1244/138851l.jpg',
    ),
    MovieItem(
      title: 'Black Clover',
      date: '2017-10-03',
      rating: '8.1',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/2/88336l.jpg',
    ),
    MovieItem(
      title: 'Solo Leveling',
      date: '2024-01-07',
      rating: '8.2',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1801/142390l.jpg',
    ),
    MovieItem(
      title: 'One Punch Man',
      date: '2015-10-05',
      rating: '8.5',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/12/76049l.jpg',
    ),
    MovieItem(
      title: 'Spy x Family',
      date: '2022-04-09',
      rating: '8.5',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1441/122795l.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Catalog')),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MovieTile(movie: movie),
          );
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({super.key, required this.movie});

  final MovieItem movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD9D9DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              movie.imageUrl,
              width: 56,
              height: 78,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 56,
                  height: 78,
                  color: const Color(0xFFDADADD),
                  child: const Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7A7A7A),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFF7C843), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieItem {
  const MovieItem({
    required this.title,
    required this.date,
    required this.rating,
    required this.imageUrl,
  });

  final String title;
  final String date;
  final String rating;
  final String imageUrl;
}
