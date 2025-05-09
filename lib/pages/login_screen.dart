// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/color.dart';
import 'package:program_visit/common/widgets/button_style.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';
import 'package:program_visit/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool enablePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundHalaman,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 90,
            top: 255,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang di VisitApp",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Satu aplikasi untuk semua \nkebutuhan anda",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 50),

              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(text: "Username"),
                    SizedBox(height: 10),
                    InputForm(
                      prefixIcon: Image.asset(
                        "assets/icons/user.png",
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
                      hintText: "Masukkan Username Anda",
                    ),

                    SizedBox(height: 20),

                    Label(text: "Password"),
                    SizedBox(height: 10),
                    InputForm(
                      obscureText: enablePassword,
                      prefixIcon: Image.asset(
                        "assets/icons/lock.png",
                        width: 22,
                        height: 22,
                      ),
                      hintText: "Masukkan Password Anda",
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    SizedBox(height: 50),

                    ButtonGradient(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
