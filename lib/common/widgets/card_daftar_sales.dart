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
    required this.gender,
  });

  final String imagePath;
  final String nama;
  final String tanggal;
  final String gender;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Gunakan nilai dinamis sesuai dengan resolusi layar
    final double avatarSize = screenWidth < 360 ? 50 : 70;
    final double fontSizeNama = screenWidth < 360 ? 15 : 18;
    final double fontSizeDetail = screenWidth < 360 ? 11 : 13;
    final double paddingHorizontal = screenWidth < 360 ? 12 : 10;

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: paddingHorizontal,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarProfile(
              radius: avatarSize / 2,
              imagePath: imagePath,
              width: avatarSize,
              height: avatarSize,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text: nama,
                    fontSize: fontSizeNama,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                  SizedBox(height: 2),
                  CustomTextStyle(
                    text: tanggal,
                    fontSize: fontSizeDetail,
                    fontWeight: AppFontWeight.regular,
                  ),
                  CustomTextStyle(
                    text: gender,
                    fontSize: fontSizeDetail,
                    fontWeight: AppFontWeight.regular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
