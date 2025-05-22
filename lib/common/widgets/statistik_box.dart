import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class StatistikBox extends StatelessWidget {
  final String title;
  final String value;
  final List<Color> colors;

  const StatistikBox({
    required this.title,
    required this.value,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CustomTextStyle(
              text: title,
              fontSize: 15,
              fontWeight: AppFontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/user-nav.png",
                  width: 14,
                  height: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                CustomTextStyle(
                  text: value,
                  fontSize: 14,
                  fontWeight: AppFontWeight.medium,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
