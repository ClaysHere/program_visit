import 'package:flutter/material.dart';

class CardDaftarToko extends StatelessWidget {
  const CardDaftarToko({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        border: Border.all(width: 1, color: Color(0xffC9C9C9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(imagePath),
    );
  }
}
