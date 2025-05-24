import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class DetailSalesView extends StatelessWidget {
  const DetailSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStyle(
          text: "Detail Sales",
          fontSize: 20,
          fontWeight: AppFontWeight.semiBold,
        ),
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ArrowBack(
            onTap: () {
              context.go("/");
            },
          ),
        ),
      ),
    );
  }
}
