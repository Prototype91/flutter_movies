import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final key = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String firstname = '';
  String lastname = '';
  String pseudo = '';
  String city = '';
  String country = '';
  String errorMessage = '';
  late String uid;

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        uid = value.user?.uid ?? '';
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(value.user?.uid)
            .set({
          "lastname": lastname,
          "firstname": firstname,
          "city": city,
          "country": country,
          "pseudo": pseudo,
          "email": value.user?.email,
        }).then((value) {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      });
    } on FirebaseException catch (error) {
      if (error.code == 'weak-password') {
        setState(() {
          errorMessage = 'Mot de passe non sécurisé';
        });
      } else if (error.code == 'email-already-in-use') {
        setState(() {
          errorMessage = 'Email déja utilisé';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text('Nouveau compte'),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre nom';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  lastname = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Nom',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre prénom';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  firstname = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Prénom',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre pseudo';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  pseudo = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Pseudo',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre ville';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  city = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Ville',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre pays';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  country = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Pays',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir une adresse email';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  email = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Mot de passe'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir un mot de passe';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  password = value!;
                });
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  register(email, password);
                }
              },
              child: const Text('Créer'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (errorMessage.isNotEmpty) Text(errorMessage),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/login'),
              child: const Text('Se connecter'),
            )
          ],
        ),
      ),
    );
  }
}
