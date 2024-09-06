import 'dart:io';

import 'package:bookshopapp/api/server_api.dart';
import 'package:bookshopapp/widgets/login_styled_text_field.dart';
import 'package:bookshopapp/widgets/pass_styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginPressed() async {
    try {
      final tokens =
          await tryAuthenticate(loginController.text, passwordController.text);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('refresh_token', tokens.refresh);
      prefs.setString('access_token', tokens.access);

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on HttpException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(153, 94, 105, 238);
    const Color hintColor = Color.fromARGB(153, 94, 105, 238);
    const Color textColor = Color.fromARGB(255, 94, 106, 238);

    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginStyledTextField(
                  controller: loginController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'example@gmail.com',
                  prefixIconData: Icons.account_circle),
              StyledPassTextField(
                  controller: passwordController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'Enter Password'),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                      color: textColor,
                      decoration: TextDecoration.underline,
                      decorationColor: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: ElevatedButton(
                  onPressed: loginPressed,
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text(
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF4F4FB),
                              fontSize: 30),
                          'Sign in')),
                ),
              )
            ],
          )),
    );
  }
}
