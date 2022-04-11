import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('UserData').doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data()! as Map<String, dynamic>;
            final lastname = data["lastname"] ?? 'Nom non renseigné';
            final firstname = data["firstname"] ?? 'Prénom non renseigné';
            final pseudo = data["pseudo"] ?? 'Pseudo non renseigné';
            final city = data["city"] ?? 'Ville non renseigné';
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
                              fontSize: 30, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(
                              0.0,
                              5,
                            ),
                          ),
                        ]),
                    child: (Column(children: [
                      Stack(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 200,
                          ),
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://geo.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fgeo.2F2020.2F01.2F08.2Fd0539a42-8114-44a0-a0bc-ae434b7ef018.2Ejpeg/1150x647/background-color/ffffff/quality/70/quelles-sont-les-plus-belles-plages-du-monde.jpg'),
                                    fit: BoxFit.cover)),
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
                                      color: Colors.white,
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
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  backgroundColor: Colors.red),
                                            ),
                                            onPressed: () => FirebaseAuth
                                                .instance
                                                .signOut()
                                                .then((value) =>
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/login')),
                                            child: const Text('Se déconnecter'),
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
                                  )
                                ],
                              )
                            ],
                          ))
                    ])),
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
