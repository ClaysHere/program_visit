import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.text, this.simbol});

  final String text;
  final String? simbol;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: simbol),
        ],
      ),
    );
  }
}
