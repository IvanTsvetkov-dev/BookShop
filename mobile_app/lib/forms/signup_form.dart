import 'package:bookshopapp/widgets/login_styled_text_field.dart';
import 'package:bookshopapp/widgets/pass_styled_text_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

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
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'First Name',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'Last Name',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: '+7(910)-999-55-33',
                  prefixIconData: Icons.account_circle),
              LoginStyledTextField(
                  validator: (value) => null,
                  padding: const EdgeInsets.only(bottom: 10),
                  textColor: textColor,
                  hintColor: hintColor,
                  borderColor: borderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  hintText: 'example@gmail.com',
                  prefixIconData: Icons.account_circle),
              StyledPassTextField(
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
                  onPressed: () {},
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
