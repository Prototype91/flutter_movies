import 'package:flutter/material.dart';
import 'package:flutter_movies/components/movies/search_movies.widget.dart';
import 'package:flutter_movies/models/movie.model.dart';

class MovieSearch extends SearchDelegate<Movie?> {
  MovieSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchMovieWidget(
      name: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.search,
            size: 50,
          ),
        ),
        Text(
          'Saisir le nom du film',
        )
      ],
    ));
  }
}
