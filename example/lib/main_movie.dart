import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Movie List',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MovieListPage(),
        );
      },
    );
  }
}

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Popular Movies'),
      ),
      body: gridview.crossAxisCount2.ratio(0.52).spacing16.ph16.builder(
            _mockMovies.length,
            (context, index) => _MovieItem(movie: _mockMovies[index]),
          ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return container.rounded16.cardShadow.white.child(
      column.children([
        // 使用AspectRatio控制海报图片比例，电影海报通常是2:3的比例
        movie.posterUrl.image.roundedT16.cover.mk,
        // 电影信息
        column.crossStart.ph12.pt12.spaceEvenly.children([
          // 电影名称
          movie.title.text.bold.f14.maxLine1.ellipsis.mk,
          // 评分
          row.children(
            [
              Icons.star.icon.yellow.s14.mk,
              w4,
              '${movie.rating}'.text.f12.orange.bold.mk,
            ],
          ),
        ]),
      ]),
    );
  }
}

class Movie {
  final String title;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.posterUrl,
    required this.rating,
  });
}

// 模拟数据
final _mockMovies = [
  const Movie(
    title: 'Inception',
    posterUrl: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
    rating: 8.8,
  ),
  const Movie(
    title: 'The Shawshank Redemption',
    posterUrl: 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
    rating: 9.3,
  ),
  const Movie(
    title: 'The Dark Knight',
    posterUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    rating: 9,
  ),
  const Movie(
    title: 'Pulp Fiction',
    posterUrl: 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
    rating: 8.9,
  ),
  const Movie(
    title: 'The Matrix',
    posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    rating: 8.7,
  ),
  const Movie(
    title: 'Forrest Gump',
    posterUrl: 'https://image.tmdb.org/t/p/w500/saHP97rTPS5eLmrLQEcANmKrsFl.jpg',
    rating: 8.8,
  ),
];
