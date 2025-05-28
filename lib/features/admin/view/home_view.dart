import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/color.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/card_customer.dart';
import 'package:program_visit/common/widgets/card_sales.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/row_text.dart';
import 'package:program_visit/common/widgets/statistik_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundHalaman,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: height * 0.25,
                padding: EdgeInsets.only(
                  top: height * 0.08,
                  right: width * 0.05,
                  bottom: height * 0.03,
                  left: width * 0.05,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff7F70D7), Color(0xffA192FA)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    CustomTextStyle(
                      text: "Selamat Datang, Admin!",
                      fontSize: width * 0.05,
                      fontWeight: AppFontWeight.bold,
                      color: Colors.white,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextStyle(
                      text:
                          "Silakan kelola data layanan, pantau aktivitas pengguna, dan pastikan semuanya berjalan lancar",
                      textAlign: TextAlign.center,
                      fontSize: width * 0.035,
                      fontWeight: AppFontWeight.regular,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.21, // responsive position
                left: width * 0.05,
                right: width * 0.05,
                child: Row(
                  children: [
                    Expanded(
                      child: StatistikBox(
                        title: "Jumlah Customer",
                        fontSize: width * 0.035,
                        value: "10 Orang",
                        colors: [Color(0xffFE6337), Color(0xffFFA58B)],
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: StatistikBox(
                        title: "Jumlah Sales",
                        fontSize: width * 0.035,
                        value: "10 Orang",
                        colors: [Color(0xffB65FD7), Color(0xffE799FA)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.06),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: width * 0.025),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              onTap: () {
                                context.go("/detail-sales");
                              },
                              child: CardSales(name: "Iqbal"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: RowText(
                      onPressed: () {
                        context.go("/daftar-customer");
                      },
                      textKiri: "Daftar Customer",
                      textKanan: "Lihat lainnya",
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: width * 0.025),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              onTap: () {
                                context.go("/detail-customer");
                              },
                              child: const CardCustomer(name: "M Fikri"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
