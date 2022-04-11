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
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: 1,
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
