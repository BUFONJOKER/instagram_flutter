import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      keyboardType: textInputType,
      obscureText: obscureText,
    );
  }
}
