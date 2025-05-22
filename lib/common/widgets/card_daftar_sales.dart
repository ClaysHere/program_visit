import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/avatar_profile.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class CardDaftarSales extends StatelessWidget {
  const CardDaftarSales({
    super.key,
    required this.imagePath,
    required this.nama,
    required this.tanggal,
    required this.button,
  });

  final String imagePath;
  final String nama;
  final String tanggal;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffc9c9c9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarProfile(imagePath: imagePath, width: 80, height: 80),

          const SizedBox(width: 25),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextStyle(
                  text: nama,
                  fontSize: 18,
                  fontWeight: AppFontWeight.semiBold,
                ),
                const SizedBox(height: 4),
                CustomTextStyle(
                  text: tanggal,
                  fontSize: 12,
                  fontWeight: AppFontWeight.regular,
                ),
                const SizedBox(height: 8),

                button,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
