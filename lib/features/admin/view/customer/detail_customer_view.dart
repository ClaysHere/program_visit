import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/button_normal.dart';
import 'package:program_visit/common/widgets/custom_tanggal.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class DetailCustomerView extends StatefulWidget {
  const DetailCustomerView({super.key});

  @override
  State<DetailCustomerView> createState() => _DetailCustomerViewState();
}

class _DetailCustomerViewState extends State<DetailCustomerView> {
  DateTime? _selectedDate;

  void _onSelectedDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStyle(
          text: "Detail Customer",
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
      body: SafeArea(
        // Ensures content doesn't overlap with status bar
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  'assets/images/man.png',
                  height: 190,
                  width: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStyle(
                        text: "M Fikri",
                        fontSize: 22,
                        fontWeight: AppFontWeight.bold,
                      ),
                      const SizedBox(height: 4),
                      CustomTextStyle(
                        text: "Nama Toko | Asal Kota",
                        fontSize: 14,
                        fontWeight: AppFontWeight.regular,
                      ),
                      const SizedBox(height: 16),
                      CustomTextStyle(
                        text:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...",
                        fontSize: 14,
                        fontWeight: AppFontWeight.regular,
                      ),

                      const SizedBox(height: 20),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatBox("Email", "fikri@gmail.com"),
                          SizedBox(height: 10),
                          _buildStatBox("Tanggal Daftar", "24 Mei 2025"),
                          SizedBox(height: 10),
                          _buildStatBox("No Telepon", "081396620900"),
                        ],
                      ),

                      const Spacer(), // Pushes button to the bottom

                      Row(
                        children: [
                          Expanded(
                            child: ButtonNormal(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.6,
                                      child: CustomTanggal(
                                        initialDate:
                                            _selectedDate ?? DateTime.now(),
                                        onSelectedDateChanged:
                                            _onSelectedDateChanged,
                                      ),
                                    );
                                  },
                                );
                              },
                              text: "Pilih jadwal visit",
                              fontSize: 15,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ButtonNormal(
                              onPressed: () {
                                context.go("/daftar-sales");
                              },
                              text: "Pilih sales",
                              fontSize: 15,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextStyle(
          text: label,
          fontSize: 14,
          fontWeight: AppFontWeight.medium,
        ),
        const SizedBox(height: 4),
        CustomTextStyle(
          text: value,
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
          color: Colors.grey,
        ),
      ],
    );
  }
}
