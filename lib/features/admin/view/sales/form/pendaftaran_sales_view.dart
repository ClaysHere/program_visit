import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/arrow_back.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/custom_tanggal.dart';
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label(text: "Username"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan username anda"),

              SizedBox(height: 15),

              Label(text: "Nama Depan"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan nama depan anda"),

              SizedBox(height: 15),

              Label(text: "Nama Belakang"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan nama belakang anda"),

              SizedBox(height: 15),

              Label(text: "Alamat"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan alamat anda"),

              SizedBox(height: 15),

              Label(text: "Email"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan email anda"),

              SizedBox(height: 15),

              Label(text: "Jenis Kelamin"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan jenis kelamin anda"),

              SizedBox(height: 15),

              Label(text: "No Handphone"),
              SizedBox(height: 5),
              InputForm(hintText: "Masukkan no handphone anda"),

              SizedBox(height: 15),

              Label(text: "Tanggal Daftar"),
              SizedBox(height: 5),
              InputForm(
                hintText: "Masukkan tanggal daftar anda",
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: CustomTanggal(
                            initialDate: _selectedDate ?? DateTime.now(),
                            onSelectedDateChanged: _onSelectedDateChanged,
                          ),
                        );
                      },
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/kalender.png",
                    color: Color(0xff7F909F),
                    width: 20,
                    height: 20,
                  ),
                ),
              ),

              SizedBox(height: 15),

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

              SizedBox(height: 40),

              ButtonGradient(
                onTap: () {
                  context.go("/daftar-sales");
                },
                title: "Simpan",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
