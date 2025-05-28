import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.onTap,
    required this.nama,
    this.color,
    this.bottom,
  });

  final VoidCallback onTap;
  final String nama;
  final Widget? bottom;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        kToolbarHeight + (bottom != null ? 50 : 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: CustomTextStyle(
              text: nama,
              fontSize: 20,
              fontWeight: AppFontWeight.semiBold,
              color: color,
            ),

            scrolledUnderElevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ArrowBack(onTap: onTap),
            ),
          ),
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: bottom!,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom != null ? 50 : 0));
}
