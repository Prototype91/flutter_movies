import 'package:flutter/material.dart';
import 'package:flutter_movies/components/movies/search_movies.dart';
import 'package:flutter_movies/dark_theme/dark_theme_provider.dart';
import 'package:flutter_movies/models/movie.model.dart';
import 'package:flutter_movies/screens/movies/movies_home.dart';
import 'package:flutter_movies/screens/user/user.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  List<Widget> list = [
    MoviesHome(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Movies', style: TextStyle(fontSize: 16)),
        leading: Switch(
          value: themeChange.darkTheme,
          onChanged: (bool value) {
            themeChange.darkTheme = value;
          },
          activeTrackColor: Colors.white,
          activeColor: Colors.deepPurple,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch<Movie?>(
                  context: context, delegate: MovieSearch());
            },
          )
        ],
      ),
      body: list[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        selectedItemColor: Colors.white,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }
}
