import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class ButtonNormal extends StatelessWidget {
  const ButtonNormal({
    super.key,
    required this.onPressed,
    required this.text,
    required this.fontSize,
    this.height = 40,
  });

  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8A4FFF), Color(0xFF6E9BFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: CustomTextStyle(
            text: text,
            fontSize: fontSize,
            fontWeight: AppFontWeight.semiBold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
