import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';

class PendaftaranSalesView extends StatefulWidget {
  const PendaftaranSalesView({super.key});

  @override
  State<PendaftaranSalesView> createState() => _PendaftaranSalesViewState();
}

class _PendaftaranSalesViewState extends State<PendaftaranSalesView> {
  bool enablePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStyle(
          text: "Pendaftaran Sales",
          fontSize: 20,
          fontWeight: AppFontWeight.semiBold,
        ),
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ArrowBack(
            onTap: () {
              context.go("/daftar-sales");
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 35, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(text: "Username"),
            SizedBox(height: 5),
            InputForm(hintText: "Masukkan username anda"),

            SizedBox(height: 10),

            Label(text: "Jenis Kelamin"),
            SizedBox(height: 5),
            InputForm(hintText: "Masukkan jenis kelamin anda"),

            SizedBox(height: 10),

            Label(text: "Alamat"),
            SizedBox(height: 5),
            InputForm(hintText: "Masukkan alamat anda"),

            SizedBox(height: 10),

            Label(text: "No Handphone"),
            SizedBox(height: 5),
            InputForm(hintText: "Masukkan no handphone anda"),

            SizedBox(height: 10),

            Label(text: "Email"),
            SizedBox(height: 5),
            InputForm(hintText: "Masukkan email anda"),

            SizedBox(height: 10),

            Label(text: "Password"),
            SizedBox(height: 5),
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
                  enablePassword ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xff7f909f),
                ),
              ),
            ),

            SizedBox(height: 88),

            ButtonGradient(
              onTap: () {
                context.go("/daftar-sales");
              },
              title: "Simpan",
            ),
          ],
        ),
      ),
    );
  }
}
