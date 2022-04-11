import 'package:flutter/material.dart';
import 'package:flutter_movies/clients/movie.client.dart';
import 'package:flutter_movies/components/movie_card.dart';
import 'package:flutter_movies/models/movie.model.dart';

// ignore: must_be_immutable
class MoviesHome extends StatelessWidget {
  MoviesHome({
    Key? key,
  }) : super(key: key);

  List<Movie>? moviesList;

  @override
  Widget build(context) {
    return FutureBuilder(
        future: Future.wait([getPopularMovies(), getTopRatedMovies()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            'Popular Movies',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data![0].length,
                      itemBuilder: (ctx, i) => MovieCard(snapshot.data![0][i]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Top Rated Movies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data![1].length,
                      itemBuilder: (ctx, i) => MovieCard(snapshot.data![1][i]),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}