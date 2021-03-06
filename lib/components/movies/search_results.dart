import 'package:flutter/material.dart';
import 'package:flutter_movies/clients/movie.client.dart';
import 'package:flutter_movies/helpers/genres.helper.dart';
import 'package:flutter_movies/models/movie.model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SearchResults extends StatefulWidget {
  final String? name;
  const SearchResults({Key? key, this.name}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Movie>? moviesList;
  @override
  void initState() {
    super.initState();
    getMoviesByName(widget.name!).then((value) {
      setState(() {
        moviesList = value.cast<Movie>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR', null);
    return Container(
      child: moviesList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : moviesList!.isEmpty
              ? const Center(
                  child: Text(
                    "Aucun film ne correspond à votre recherche",
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: moviesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String genre = 'Pas de catégorie';
                    // ignore: prefer_is_empty
                    if (moviesList![index].genreIds?.length != 0) {
                      genre = getGenreById(moviesList![index].genreIds![0]);
                    }
                    String date = 'Date inconnue';
                    if (moviesList![index].releaseDate != '') {
                      date = DateFormat.yMMMEd('fr-FR').format(
                          DateTime.parse(moviesList![index].releaseDate!));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/details',
                            arguments: {
                              'id': moviesList![index].id.toString(),
                              'title':
                                  moviesList![index].title ?? 'Titre inconnu',
                              'posterPath': 'https://image.tmdb.org/t/p/w500/' +
                                  (moviesList![index].posterPath ?? ''),
                              'overview': moviesList![index].overview ??
                                  'Pas de description',
                              'voteAverage':
                                  moviesList![index].voteAverage ?? '0',
                              'genre': genre,
                              'date': date
                            },
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: moviesList![index].posterPath == null
                                        ? Image.asset(
                                            'assets/images/404.gif',
                                            fit: BoxFit.cover,
                                          )
                                        : FadeInImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500/' +
                                                    moviesList![index]
                                                        .posterPath!),
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(
                                                'assets/images/loading.gif'),
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          moviesList![index].title ??
                                              'Titre inconnu',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2.5,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Catégorie : $genre',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 2.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Sortie : $date',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 2.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              (moviesList![index].voteAverage ==
                                                      '0'
                                                  ? 'Pas de note'
                                                  : (moviesList![index]
                                                          .voteAverage! +
                                                      ' / 10')),
                                              style: const TextStyle(
                                                letterSpacing: 2.5,
                                              ),
                                            ),
                                            const Icon(Icons.star,
                                                color: Colors.deepPurple)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
