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

class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  final Set<String> _favoriteTitles = <String>{};

  static const List<MovieItem> _movies = [
    MovieItem(
      title: 'Sakamoto Days',
      date: '2025-01-11',
      rating: '7.6',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1026/146459l.jpg',
      description:
          'Tarou Sakamoto adalah pembunuh bayaran legendaris yang memilih pensiun dan menjalani hidup tenang sebagai pemilik minimarket bersama keluarganya.',
    ),
    MovieItem(
      title: 'One Piece',
      date: '1999-10-20',
      rating: '8.7',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1244/138851l.jpg',
      description:
          'Monkey D. Luffy berlayar bersama kru Topi Jerami untuk mencari harta karun legendaris One Piece dan menjadi Raja Bajak Laut.',
    ),
    MovieItem(
      title: 'Black Clover',
      date: '2017-10-03',
      rating: '8.1',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/2/88336l.jpg',
      description:
          'Asta, anak tanpa sihir di dunia penuh sihir, berjuang keras untuk meraih mimpinya menjadi Kaisar Sihir dengan tekad tanpa batas.',
    ),
    MovieItem(
      title: 'Solo Leveling',
      date: '2024-01-07',
      rating: '8.2',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1801/142390l.jpg',
      description:
          'Sung Jinwoo, hunter terlemah, memperoleh kekuatan unik yang memungkinkannya naik level sendiri dan berubah menjadi hunter terkuat.',
    ),
    MovieItem(
      title: 'One Punch Man',
      date: '2015-10-05',
      rating: '8.5',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/12/76049l.jpg',
      description:
          'Saitama terlalu kuat hingga selalu mengalahkan musuh dengan satu pukulan, membuat hidup pahlawannya terasa membosankan.',
    ),
    MovieItem(
      title: 'Spy x Family',
      date: '2022-04-09',
      rating: '8.5',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1441/122795l.jpg',
      description:
          'Mata-mata elite Loid Forger membentuk keluarga palsu untuk misi rahasia, tanpa tahu istrinya pembunuh bayaran dan anaknya bisa membaca pikiran.',
    ),
  ];

  bool _isFavorite(MovieItem movie) {
    return _favoriteTitles.contains(movie.title);
  }

  void _toggleFavorite(MovieItem movie) {
    setState(() {
      if (_favoriteTitles.contains(movie.title)) {
        _favoriteTitles.remove(movie.title);
      } else {
        _favoriteTitles.add(movie.title);
      }
    });
  }

  void _openMovieDetail(MovieItem movie) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return MovieDetailPage(
            movie: movie,
            isFavorite: _isFavorite(movie),
            onToggleFavorite: () => _toggleFavorite(movie),
          );
        },
      ),
    );
  }

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
            child: MovieTile(
              movie: movie,
              isFavorite: _isFavorite(movie),
              onTap: () => _openMovieDetail(movie),
              onToggleFavorite: () => _toggleFavorite(movie),
            ),
          );
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final MovieItem movie;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F0F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFD9D9DF)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                        const Icon(
                          Icons.star,
                          color: Color(0xFFF7C843),
                          size: 16,
                        ),
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
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Text(
                          'Lihat detail',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF455A64),
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color(0xFF455A64),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                tooltip: isFavorite
                    ? 'Hapus dari favorite'
                    : 'Tambahkan ke favorite',
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : const Color(0xFF707070),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final MovieItem movie;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _handleToggleFavorite() {
    widget.onToggleFavorite();
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
        actions: [
          IconButton(
            onPressed: _handleToggleFavorite,
            tooltip: _isFavorite
                ? 'Hapus dari favorite'
                : 'Tambahkan ke favorite',
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : const Color(0xFF707070),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 190),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.network(
                      widget.movie.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFDADADD),
                          child: const Icon(
                            Icons.movie_creation_outlined,
                            color: Colors.white,
                            size: 56,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.movie.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF666666),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.movie.date,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.star, size: 16, color: Color(0xFFF7C843)),
                const SizedBox(width: 4),
                Text(
                  widget.movie.rating,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.movie.description,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _handleToggleFavorite,
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  _isFavorite ? 'Hapus dari Favorite' : 'Tambah ke Favorite',
                ),
              ),
            ),
          ],
        ),
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
    required this.description,
  });

  final String title;
  final String date;
  final String rating;
  final String imageUrl;
  final String description;
}
