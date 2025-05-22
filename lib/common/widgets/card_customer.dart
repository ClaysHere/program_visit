import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class CardCustomer extends StatelessWidget {
  const CardCustomer({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xffC9C9C9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            child: ClipOval(
              child: Image.asset(
                "assets/icons/profile.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5),

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
