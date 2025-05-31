// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/bottom_navbar.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';
import 'package:program_visit/common/widgets/custom_dropdown_buton.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/datetime_input_form.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';

class FormPendaftaranUser extends StatefulWidget {
  const FormPendaftaranUser({super.key});

  @override
  State<FormPendaftaranUser> createState() => _FormPendaftaranUserState();
}

class _FormPendaftaranUserState extends State<FormPendaftaranUser> {
  bool enablePassword = true;
  DateTime? _selectedDate;

  void _onSelectedDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final double paddingHorizontal = screenWidth * 0.04;
    final double verticalSpacing = screenHeight * 0.02;
    final bool isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: CustomAppbar(
        onTap: () {
          context.go("/");
        },
        nama: "Pendaftaran User",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {},
              child: CustomTextStyle(
                text: "Simpan",
                fontSize: 17,
                fontWeight: AppFontWeight.medium,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: paddingHorizontal,
          right: paddingHorizontal,
          top: verticalSpacing,
        ), // Padding bawah sedikit lebih besar
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Efek scroll iOS/Android
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
              ), // Batas lebar maksimum untuk tablet/desktop
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(text: "Pilih User"),
                  SizedBox(height: verticalSpacing * 0.25),
                  CustomDropdownButon(),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Nama Depan"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan nama depan anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Nama Belakang"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan nama belakang anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Username"),
                  SizedBox(
                    height: verticalSpacing * 0.25,
                  ), // Spasi yang lebih kecil
                  InputForm(hintText: "Masukkan username anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Password"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan password anda",
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          enablePassword = !enablePassword;
                        });
                      },
                      icon: Icon(
                        enablePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(0xff7f909f),
                        size:
                            isSmallScreen
                                ? 20
                                : 24, // Ukuran ikon juga responsif
                      ),
                    ),
                  ),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Tanggal Daftar"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputFormDatetime(
                    onSelectedDateChanged: _onSelectedDateChanged,
                  ),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Alamat"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan alamat anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Email"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan email anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "Jenis Kelamin"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan jenis kelamin anda"),

                  SizedBox(height: verticalSpacing),

                  Label(text: "No Handphone"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan no handphone anda"),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
