import 'package:flutter_movies/models/movie_list.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getPopularMovies() async {
  MovieList movieList;
  final res = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=4d196b83a81a1379fde8fb79e2df0116&language=fr-FR&page=1'));
  final decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies ?? [];
}

Future<List> getTopRatedMovies() async {
  MovieList movieList;
  final res = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=4d196b83a81a1379fde8fb79e2df0116&language=fr-FR&page=1'));
  final decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies ?? [];
}

Future<List> getUpcomingMovies() async {
  MovieList movieList;
  final res = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?api_key=4d196b83a81a1379fde8fb79e2df0116&language=en-US&page=1'));
  final decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies ?? [];
}

Future<List> getMoviesByName(String name) async {
  MovieList movieList;
  final res = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/search/movie/?query=$name&api_key=4d196b83a81a1379fde8fb79e2df0116&language=fr-FR&page=1'));
  final decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies ?? [];
}
