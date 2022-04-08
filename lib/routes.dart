import 'package:flutter/material.dart';
import 'package:flutter_movies/screens/authentication/login.dart';
import 'package:flutter_movies/screens/authentication/register.dart';
import 'package:flutter_movies/screens/home.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const MyHomePage(title: 'Flutter Movies'),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/other': (context) => Scaffold(
        appBar: AppBar(),
      ),
};
