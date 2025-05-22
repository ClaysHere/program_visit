import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/button_normal.dart';
import 'package:program_visit/common/widgets/card_daftar_sales.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/pagination.dart';

class DaftarSalesView extends StatelessWidget {
  const DaftarSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStyle(
          text: "Daftar Sales",
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 35,
          top: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CardDaftarSales(
                      imagePath: "assets/icons/profile.png",
                      nama: 'M Fikri',
                      tanggal: "22 Mei 2025 (tanggal daftar)",
                      button: ButtonNormal(
                        onPressed: () {},
                        text: "Lihat Detail",
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Pagination(label: "Halaman 1 dari 10"),

            SizedBox(height: 15),

            ButtonGradient(
              onTap: () {
                context.go("/pendaftaran-sales");
              },
              title: "Tambah Sales",
            ),
          ],
        ),
      ),
    );
  }
}
