import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/color.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/card_customer.dart';
import 'package:program_visit/common/widgets/card_toko.dart';
import 'package:program_visit/common/widgets/card_sales.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/row_text.dart';
import 'package:program_visit/common/widgets/statistik_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundHalaman,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.only(
                    top: 60,
                    right: 30,
                    bottom: 30,
                    left: 30,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff7F70D7), Color(0xffA192FA)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomTextStyle(
                        text: "Selamat Datang, Admin!",
                        fontSize: 20,
                        fontWeight: AppFontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      CustomTextStyle(
                        text:
                            "Silakan kelola data layanan, pantau aktivitas pengguna, dan pastikan semuanya berjalan lancar",
                        textAlign: TextAlign.center,
                        fontSize: 14,
                        fontWeight: AppFontWeight.regular,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      StatistikBox(
                        title: "Jumlah Customer",
                        value: "10 Orang",
                        colors: [Color(0xffFE6337), Color(0xffFFA58B)],
                      ),
                      const SizedBox(width: 16),
                      StatistikBox(
                        title: "Jumlah Sales",
                        value: "10 Orang",
                        colors: [Color(0xffB65FD7), Color(0xffE799FA)],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RowText(
                onPressed: () {
                  context.go("/daftar-sales");
                },
                textKiri: "Daftar Sales",
                textKanan: "Lihat lainnya",
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CardSales(name: "Joko"),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RowText(
                onPressed: () {},
                textKiri: "Daftar Customer",
                textKanan: "Lihat lainnya",
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CardCustomer(name: "Joko"),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RowText(
                onPressed: () {},
                textKiri: "Daftar Toko",
                textKanan: "Lihat lainnya",
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CardDaftarToko(
                        name: "Makmur Jaya",
                        imagePath: "assets/images/toko.webp",
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
