import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/avatar_profile.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class DetailSalesView extends StatelessWidget {
  const DetailSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.35,
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.05,
                    top: 9,
                    child: ArrowBack(
                      width: 40,
                      height: 40,
                      onTap: () {
                        context.go("/daftar-sales");
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AvatarProfile(
                      imagePath: 'assets/images/man.png',
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      radius: screenWidth * 0.2,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextStyle(
                          text: "M Fikri",
                          fontSize: 18,
                          fontWeight: AppFontWeight.bold,
                          color: Color(0xff8793AA),
                        ),
                        const SizedBox(height: 5),
                        const CustomTextStyle(
                          text:
                              "Jl. Letda Sujono, Gg. Abadi, Medan, Sumatera Utara",
                          fontSize: 13,
                          fontWeight: AppFontWeight.regular,
                          color: Color(0xff8793AA),
                        ),
                        const SizedBox(height: 2),
                        const CustomTextStyle(
                          text: "27 Mei 2025",
                          fontSize: 12,
                          fontWeight: AppFontWeight.regular,
                          color: Color(0xff8793AA),
                        ),
                        const SizedBox(height: 15),
                        const CustomTextStyle(
                          text: "Deskripsi",
                          fontSize: 18,
                          fontWeight: AppFontWeight.bold,
                          color: Color(0xff8793AA),
                        ),
                        const SizedBox(height: 10),
                        const CustomTextStyle(
                          textAlign: TextAlign.justify,
                          text:
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                          fontSize: 13,
                          fontWeight: AppFontWeight.regular,
                          color: Color(0xff8793AA),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomTextStyle(
                              text: "Email",
                              fontSize: 13,
                              fontWeight: AppFontWeight.bold,
                              color: Color(0xff8793AA),
                            ),
                            SizedBox(height: 2),
                            CustomTextStyle(
                              text: "mfikri12@gmail.com",
                              fontSize: 13,
                              fontWeight: AppFontWeight.regular,
                              color: Color(0xff8793AA),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomTextStyle(
                              text: "No Telepon",
                              fontSize: 13,
                              fontWeight: AppFontWeight.bold,
                              color: Color(0xff8793AA),
                            ),
                            SizedBox(height: 2),
                            CustomTextStyle(
                              text: "081396620900",
                              fontSize: 13,
                              fontWeight: AppFontWeight.regular,
                              color: Color(0xff8793AA),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomTextStyle(
                              text: "Jenis Kelamin",
                              fontSize: 13,
                              fontWeight: AppFontWeight.bold,
                              color: Color(0xff8793AA),
                            ),
                            SizedBox(height: 2),
                            CustomTextStyle(
                              text: "Laki-laki",
                              fontSize: 13,
                              fontWeight: AppFontWeight.regular,
                              color: Color(0xff8793AA),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Extra space at the bottom
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
