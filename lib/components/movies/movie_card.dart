import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_movies/helpers/genres.helper.dart';
import 'package:flutter_movies/models/movie.model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  Movie movie;
  MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR', null);
    final String genre = getGenreById(movie.genreIds![0]);
    final DateTime date = DateTime.parse(movie.releaseDate!);
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/details',
            arguments: {
              'id': movie.id.toString(),
              'title': movie.title ?? '',
              'posterPath':
                  'https://image.tmdb.org/t/p/w500/' + (movie.posterPath ?? ''),
              'overview': movie.overview ?? '',
              'voteAverage': movie.voteAverage ?? '',
              'genre': genre,
              'date': DateFormat.yMMMEd('fr-FR').format(date)
            },
          );
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: Random().nextInt(100000).toString(),
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
                overflow: TextOverflow.ellipsis,
                fontSize: 13,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              DateFormat.yMMMEd('fr-FR').format(date),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              genre,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
