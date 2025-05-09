import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        prefixIcon: Padding(padding: EdgeInsets.all(12), child: prefixIcon),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
