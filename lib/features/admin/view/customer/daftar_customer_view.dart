import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/button_normal.dart';
import 'package:program_visit/common/widgets/card_daftar_customer.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/pagination.dart';

class DaftarCustomerView extends StatelessWidget {
  const DaftarCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStyle(
          text: "Daftar Customer",
          fontSize: 20,
          fontWeight: AppFontWeight.semiBold,
        ),
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ArrowBack(
            onTap: () {
              context.go("");
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CardDaftarCustomer(
                      imagePath: "assets/icons/profile.png",
                      nama: 'M Fikri',
                      tanggal: "22 Mei 2025 (tanggal daftar)",
                      button: ButtonNormal(
                        onPressed: () {
                          context.go("/detail-customer");
                        },
                        text: "Lihat Detail",
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Pagination(label: "Halaman 1 dari 10"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ButtonGradient(
          onTap: () {
            context.go("/pendaftaran-customer");
          },
          title: "Tambah Customer",
        ),
      ),
    );
  }
}
