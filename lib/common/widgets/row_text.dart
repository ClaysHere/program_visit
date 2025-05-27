import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.textKiri,
    required this.textKanan,
    required this.onPressed,
  });

  final String textKiri;
  final String textKanan;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextStyle(
          text: textKiri,
          fontSize: 16,
          fontWeight: AppFontWeight.medium,
          color: Color(0xff414549),
        ),
        TextButton(
          onPressed: onPressed,
          child: CustomTextStyle(
            text: textKanan,
            fontSize: 12,
            fontWeight: AppFontWeight.regular,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
