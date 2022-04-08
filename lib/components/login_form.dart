import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final key = GlobalKey<FormState>();
  String email = '', password = '', errorMessage = '';

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushReplacementNamed('/'),
          );
    } on FirebaseException catch (error) {
      if (error.code == 'weak-password') {
        setState(() {
          errorMessage = 'weak-password';
        });
      } else if (error.code == 'email-already-in-use') {
        setState(() {
          errorMessage = 'email-already-in-use';
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
            const Text('Login'),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
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
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
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
                  signIn(email, password);
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (errorMessage.isNotEmpty) Text(errorMessage)
          ],
        ),
      ),
    );
  }
}
