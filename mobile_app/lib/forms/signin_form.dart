import 'package:bookshopapp/widgets/pass_styled_text_field.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: loginController,
                  style: const TextStyle(color: textColor),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: borderColor,
                    ),
                    hintStyle: TextStyle(color: hintColor),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: "Enter email",
                  ),
                ),
              ),
              StyledPassTextField(
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
                  onPressed: () {},
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
