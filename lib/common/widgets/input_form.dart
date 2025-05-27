import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/color.dart';
import 'package:program_visit/common/styles/font.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.obscureText = false,
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
          fontWeight: AppFontWeight.medium,
          fontSize: 15,
          color: Color(0xff7F909F),
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
        fillColor: AppColors.backgroundInputField,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
