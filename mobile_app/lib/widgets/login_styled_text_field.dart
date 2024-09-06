import 'package:flutter/material.dart';

class LoginStyledTextField extends StatelessWidget {
  const LoginStyledTextField(
      {super.key,
      required this.textColor,
      required this.hintColor,
      required this.borderColor,
      required this.borderRadius,
      required this.hintText,
      required this.prefixIconData,
      required this.padding,
      required this.validator,
      this.controller = null,
      this.obscureText = false});
  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final BorderRadius borderRadius;
  final IconData prefixIconData;
  final String hintText;
  final bool obscureText;
  final EdgeInsets padding;
  final TextEditingController? controller;
  final String? Function(String? value) validator;

  EdgeInsets getEdgeInsets(BuildContext context){
    final Size size = MediaQuery.sizeOf(context);
    if (size.height < 700){
      return const EdgeInsets.all(5);
    }
    else{
      return const EdgeInsets.symmetric(vertical: 15, horizontal: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    

    return Padding(
      padding: padding,
      child: SizedBox(
        child: TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            contentPadding: getEdgeInsets(context),
            prefixIcon: Icon(
              prefixIconData,
              color: borderColor,
            ),
            hintStyle: TextStyle(color: hintColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
                borderRadius: borderRadius),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 3.0),
                borderRadius: borderRadius),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
