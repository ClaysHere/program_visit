import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';
import 'package:program_visit/common/widgets/custom_tanggal.dart';
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
    // Mengambil ukuran layar penuh
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Menentukan padding horizontal berdasarkan lebar layar
    // Misalnya, 4% dari lebar layar untuk padding horizontal
    final double paddingHorizontal = screenWidth * 0.04;
    // Spasi vertikal antar elemen, bisa disesuaikan dengan proporsi layar
    final double verticalSpacing = screenHeight * 0.02; // 2% dari tinggi layar

    // Menentukan apakah layar dianggap 'kecil' (misalnya, lebar < 360 dp)
    // Anda bisa menyesuaikan threshold ini
    final bool isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: CustomAppbar(
        onTap: () {
          // Pastikan rute ini benar, jika tidak, bisa menyebabkan error GoRouter
          // context.go("/daftar-sales");
          // Lebih umum untuk kembali ke halaman sebelumnya jika ini adalah form pendaftaran
          context.pop(); // Kembali ke halaman sebelumnya
        },
        nama: "Pendaftaran User",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: verticalSpacing,
        ).copyWith(
          bottom: verticalSpacing * 1.5,
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
                  Label(text: "Username"),
                  SizedBox(
                    height: verticalSpacing * 0.25,
                  ), // Spasi yang lebih kecil
                  InputForm(hintText: "Masukkan username anda"),

                  SizedBox(height: verticalSpacing), // Spasi standar
                  Label(text: "Nama Depan"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan nama depan anda"),

                  SizedBox(height: verticalSpacing),
                  Label(text: "Nama Belakang"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(hintText: "Masukkan nama belakang anda"),

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

                  SizedBox(height: verticalSpacing),
                  Label(text: "Tanggal Daftar"),
                  SizedBox(height: verticalSpacing * 0.25),
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
                              // Menggunakan proporsi tinggi layar
                              height: screenHeight * 0.6,
                              padding: EdgeInsets.all(
                                paddingHorizontal,
                              ), // Padding modal juga responsif
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
                        width:
                            isSmallScreen
                                ? 18
                                : 24, // Ukuran ikon juga responsif
                        height: isSmallScreen ? 18 : 24,
                      ),
                    ),
                  ),

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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: paddingHorizontal,
            right: paddingHorizontal,
            bottom: verticalSpacing, // Menggunakan spasi responsif
          ),
          child: ButtonGradient(
            onTap: () {
              context.go("/daftar-sales");
            },
            title: "Simpan",
          ),
        ),
      ),
    );
  }
}
