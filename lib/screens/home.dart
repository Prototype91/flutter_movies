import 'package:flutter/material.dart';
import 'package:flutter_movies/screens/movies/movies_home.dart';
import 'package:flutter_movies/screens/movies/movies_search.dart';
import 'package:flutter_movies/screens/user/user.dart';

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
    const MoviesSearch(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Movies',
            style: TextStyle(fontSize: 16)),
        // Removes the back button
        automaticallyImplyLeading: false
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
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_movies), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }
}
