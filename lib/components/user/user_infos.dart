import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    return FutureBuilder(
        future: Future.wait([
          Future.delayed(const Duration(seconds: 1)),
          FirebaseFirestore.instance.collection('UserData').doc(uid).get()
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data![1].data()! as Map<String, dynamic>;
            final lastname = data["lastname"] ?? 'Nom non renseigné';
            final firstname = data["firstname"] ?? 'Prénom non renseigné';
            final pseudo = data["pseudo"] ?? 'Pseudo non renseigné';
            final city = data["city"] ?? 'Ville non renseignée';
            final country = data["country"] ?? 'Pays non renseigné';
            final email = data["email"] ?? 'Email non renseigné';
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Profile',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ))
                    ],
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: (Column(children: [
                      Stack(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 200,
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: (Container(
                                    width: 95,
                                    height: 95,
                                    margin: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: (SizedBox(
                                      height: 100,
                                      child: (Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('$firstname $lastname',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18)),
                                          Text(
                                            '$city, $country',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                    )))
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    const Icon(Icons.account_circle_outlined),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text('$pseudo',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.alternate_email),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text('$email',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: ElevatedButton(
                                        onPressed: () => FirebaseAuth.instance
                                            .signOut()
                                            .then((value) =>
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/login')),
                                        child: const Text('Se déconnecter',
                                            style:
                                                TextStyle(letterSpacing: 1.5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ])),
                  )
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
