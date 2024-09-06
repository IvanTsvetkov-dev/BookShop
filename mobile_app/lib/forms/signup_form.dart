import 'dart:io';

import 'package:bookshopapp/api/server_api.dart';
import 'package:bookshopapp/models/user.dart';
import 'package:bookshopapp/widgets/login_styled_text_field.dart';
import 'package:bookshopapp/widgets/pass_styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> signUpPressed() async {
    try {
      await tryRegister(User(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passController.text,
          phone: phoneController.text));

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Signed Up!')));
      }
    } on HttpException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString())));
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
                  controller: firstNameController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'First Name',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  controller: lastNameController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'Last Name',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  controller: phoneController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: '+7(910)-999-55-33',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  controller: emailController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'example@gmail.com',
                  prefixIconData: Icons.account_circle),
              StyledPassTextField(
                  controller: passController,
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'Password'),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: ElevatedButton(
                  onPressed: signUpPressed,
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF4F4FB),
                              fontSize: 30),
                          'Sign Up')),
                ),
              )
            ],
          )),
    );
  }
}
