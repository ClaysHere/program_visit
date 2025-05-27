import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/card_daftar_sales.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';
import 'package:program_visit/common/widgets/custom_search.dart';

class DaftarSalesView extends StatelessWidget {
  const DaftarSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final paddingHorizontal = width * 0.05;
    final spacing = height * 0.015;

    return Scaffold(
      appBar: CustomAppbar(
        nama: "Daftar Sales",
        onTap: () {
          context.go("/");
        },
        bottom: CustomSearch(hintText: "masukkan nama sales"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: spacing,
        ),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          separatorBuilder: (_, __) => SizedBox(height: spacing),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.go("/detail-sales");
              },
              child: CardDaftarSales(
                imagePath: "assets/icons/profile.png",
                nama: 'M Fikri',
                tanggal: "22 Mei 2025",
                gender: 'Laki-laki',
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: paddingHorizontal,
            right: paddingHorizontal,
            bottom: spacing,
          ),
          child: ButtonGradient(
            onTap: () {
              context.go("/pendaftaran-sales");
            },
            title: "Tambah Sales",
          ),
        ),
      ),
    );
  }
}
