import 'package:flutter/material.dart';
import 'package:flutter_movies/screens/authentication/login.dart';
import 'package:flutter_movies/screens/authentication/register.dart';
import 'package:flutter_movies/screens/home.dart';
import 'package:flutter_movies/screens/movies/movie_details.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const MyHomePage(title: 'Flutter Movies'),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/movie-details': (context) => const MovieDetailsScreen(),
  '/other': (context) => Scaffold(
        appBar: AppBar(),
      ),
};
