import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie.model.dart';

// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  Movie movie;
  MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/movie-details',
            arguments: {
              'id': movie.id.toString(),
              'title': movie.title ?? '',
              'posterPath':
                  'https://image.tmdb.org/t/p/w500/' + (movie.posterPath ?? ''),
              'overview': movie.overview ?? '',
              'voteAverage': movie.voteAverage ?? '',
            },
          );
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: Random().nextInt(100).toString(),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                          (movie.posterPath ?? '')),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Text(
              movie.title ?? 'Titre inconnu',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Date de sortie : ' + (movie.releaseDate ?? 'Date inconnue'),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
