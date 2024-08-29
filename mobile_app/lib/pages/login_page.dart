import 'package:bookshopapp/forms/signin_form.dart';
import 'package:bookshopapp/forms/signup_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.white,
      body: Center(
        child: SignInForm(),
      ),
    );
  }
}
