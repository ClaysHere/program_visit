import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class CardDaftarToko extends StatelessWidget {
  const CardDaftarToko({
    super.key,
    required this.name,
    required this.imagePath,
  });

  final String name;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xffC9C9C9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 190,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 10),

          CustomTextStyle(
            text: name,
            fontSize: 13,
            fontWeight: AppFontWeight.semiBold,
            color: Color(0xff959595),
          ),
        ],
      ),
    );
  }
}
