import 'package:flutter/material.dart';
import 'package:flutter_movies/clients/movie.client.dart';
import 'package:flutter_movies/models/movie.model.dart';

class SearchMovieWidget extends StatefulWidget {
  final String? name;
  const SearchMovieWidget({Key? key, this.name}) : super(key: key);

  @override
  _SearchMovieWidgetState createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/movie-details',
                            arguments: {
                              'id': moviesList![index].id.toString(),
                              'title': moviesList![index].title ?? '',
                              'posterPath': 'https://image.tmdb.org/t/p/w500/' +
                                  (moviesList![index].posterPath ?? ''),
                              'overview': moviesList![index].overview ?? '',
                              'voteAverage':
                                  moviesList![index].voteAverage ?? '',
                            },
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 70,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500/' +
                                              (moviesList![index].posterPath ??
                                                  '')),
                                      fit: BoxFit.cover,
                                      placeholder: const AssetImage(''),
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
                                          moviesList![index].title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              moviesList![index].voteAverage ??
                                                  '12',
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
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 24.0),
                            //   child: Divider(),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
