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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CardDaftarSales(
                    imagePath: "assets/images/man.png",
                    nama: 'Jhon Doe',
                    tanggal: 'JL. Kemanggisan Utara, Medan',
                    button: ButtonNormal(
                      onPressed: () {},
                      text: "Lihat Detail",
                    ),
                  ),

                  SizedBox(height: 10),

                  CardDaftarSales(
                    imagePath: "assets/images/man.png",
                    nama: 'Irfan Mulya',
                    tanggal: 'JL. Kemanggisan Utara, Medan',
                    button: ButtonNormal(
                      onPressed: () {},
                      text: "Lihat Detail",
                    ),
                  ),

                  SizedBox(height: 10),

                  CardDaftarSales(
                    imagePath: "assets/images/man.png",
                    nama: 'M Fikri',
                    tanggal: 'JL. Kemanggisan Utara, Medan',
                    button: ButtonNormal(
                      onPressed: () {},
                      text: "Lihat Detail",
                    ),
                  ),

                  SizedBox(height: 10),

                  CardDaftarSales(
                    imagePath: "assets/images/man.png",
                    nama: 'M Fikri',
                    tanggal: 'JL. Kemanggisan Utara, Medan',
                    button: ButtonNormal(
                      onPressed: () {},
                      text: "Lihat Detail",
                    ),
                  ),

                  SizedBox(height: 10),

                  CardDaftarSales(
                    imagePath: "assets/images/man.png",
                    nama: 'M Fikri',
                    tanggal: 'JL. Kemanggisan Utara, Medan',
                    button: ButtonNormal(
                      onPressed: () {},
                      text: "Lihat Detail",
                    ),
                  ),
                ],
              ),
            ),

            Pagination(label: "Halaman 1 dari 10"),

            SizedBox(height: 30),

            ButtonGradient(onTap: () {}, title: "Tambah Sales"),
          ],
        ),
      ),
    );
  }
}
