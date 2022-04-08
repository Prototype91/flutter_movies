import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final key = GlobalKey<FormState>();
  String email = '', password = '', errorMessage = '';

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushReplacementNamed('/login'),
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
            const Text('Register'),
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
                  register(email, password);
                }
              },
              child: const Text('Register'),
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
