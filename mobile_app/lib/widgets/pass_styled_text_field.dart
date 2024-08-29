import 'package:flutter/material.dart';

class StyledPassTextField extends StatefulWidget {
  const StyledPassTextField(
      {super.key,
      required this.textColor,
      required this.hintColor,
      required this.borderColor,
      required this.borderRadius,
      required this.hintText,
      required this.padding,
      required this.validator,
      this.controller = null,
      this.obscureText = false});

  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final BorderRadius borderRadius;
  final String hintText;
  final bool obscureText;
  final EdgeInsets padding;
  final TextEditingController? controller;
  final String? Function(String? value) validator;

  @override
  State<StyledPassTextField> createState() => _StyledPassTextFieldState();
}

class _StyledPassTextFieldState extends State<StyledPassTextField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
