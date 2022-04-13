import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movies/clients/movie.client.dart';
import 'package:flutter_movies/components/movies/movie_card.dart';
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
        future: Future.wait([
          Future.delayed(const Duration(seconds: 1)),
          getPopularMovies(),
          getTopRatedMovies(),
          getUpcomingMovies()
        ]),
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
                            'Films populaires',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
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
                      itemCount: snapshot.data![1].length,
                      itemBuilder: (ctx, i) => MovieCard(snapshot.data![1][i]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Films les mieux notés',
                          style: TextStyle(
                            letterSpacing: 2.5,
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
                      itemCount: snapshot.data![2].length,
                      itemBuilder: (ctx, i) => MovieCard(snapshot.data![2][i]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Films à venir',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data![3].length,
                      itemBuilder: (ctx, i) => MovieCard(snapshot.data![3][i]),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
