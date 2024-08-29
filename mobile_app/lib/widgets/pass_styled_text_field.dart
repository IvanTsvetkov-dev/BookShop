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
      this.controller = null});

  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final BorderRadius borderRadius;
  final String hintText;
  final EdgeInsets padding;
  final TextEditingController? controller;
  final String? Function(String? value) validator;

  @override
  State<StyledPassTextField> createState() => _StyledPassTextFieldState();
}

class _StyledPassTextFieldState extends State<StyledPassTextField> {
  bool obscureText = true;

  IconData getIcon() {
    if (obscureText) {
      return Icons.visibility;
      
    } else {
      return Icons.visibility_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        style: TextStyle(color: widget.textColor),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: widget.borderColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                getIcon(),
                color: widget.borderColor,
              )),
          hintStyle: TextStyle(color: widget.hintColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 2.0),
              borderRadius: widget.borderRadius),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 3.0),
              borderRadius: widget.borderRadius),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
