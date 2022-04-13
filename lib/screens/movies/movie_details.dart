import 'dart:math';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String id = routeArgs['id'] ?? Random().nextInt(100000).toString();
    final rating = routeArgs['voteAverage'];
    final genre = routeArgs['genre'];
    final date = routeArgs['date'];

    return Scaffold(
      appBar: AppBar(
          title: const Text('Fiche du Film',
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2.5,
              )),
          elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Hero(
                    tag: id,
                    child: SizedBox(
                      height: 450,
                      child: routeArgs['posterPath'] ==
                              'https://image.tmdb.org/t/p/w500/'
                          ? Image.asset(
                              'assets/images/404.gif',
                              fit: BoxFit.cover,
                            )
                          : FadeInImage(
                            width: 375,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      (routeArgs['posterPath']!)),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
                            ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              routeArgs['title']!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Date de sortie : $date',
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Catégorie : $genre',
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            size: 45,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (rating == '0' ? 'Pas de note' : '$rating / 10'),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Description : ' +
                  (routeArgs['overview'] == ''
                      ? 'Aucune description'
                      : routeArgs['overview']!),
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
