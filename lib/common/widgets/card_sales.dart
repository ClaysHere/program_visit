import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/avatar_profile.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class CardSales extends StatelessWidget {
  const CardSales({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Color(0xffc9c9c9),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarProfile(
              radius: 30,
              imagePath: "assets/icons/profile.png",
              width: 60,
              height: 60,
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: CustomTextStyle(
                text: name,
                fontSize: 13,
                fontWeight: AppFontWeight.bold,
                color: Colors.black45,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
