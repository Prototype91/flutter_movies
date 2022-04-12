import 'package:flutter/material.dart';
import 'package:flutter_movies/components/authentication/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: const Scaffold(
        body: SingleChildScrollView(
          child: RegisterForm(),
        ),
      ),
    );
  }
}
