import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool enablePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/banner-login.png",
                width: 283,
                height: 170,
              ),
            ),

            SizedBox(height: 69),

            CustomTextStyle(
              text: "Selamat Datang di VisitApp",
              fontSize: 23,
              fontWeight: AppFontWeight.bold,
            ),

            SizedBox(height: 10),

            CustomTextStyle(
              text: "Satu applikasi untuk semua \nkebutuhan anda",
              fontSize: 15,
              fontWeight: AppFontWeight.regular,
            ),

            SizedBox(height: 50),

            Label(text: "Username", simbol: " *"),
            SizedBox(height: 10),
            InputForm(
              obscureText: enablePassword,
              prefixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  "assets/icons/user.png",
                  width: 22,
                  height: 22,
                ),
              ),
              hintText: "Masukkan Username Anda",
            ),

            SizedBox(height: 15),

            Label(text: "Password", simbol: " *"),
            SizedBox(height: 10),
            InputForm(
              obscureText: enablePassword,
              prefixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  "assets/icons/lock.png",
                  width: 22,
                  height: 22,
                ),
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
                  enablePassword ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xff7f909f),
                ),
              ),
            ),

            SizedBox(height: 45),

            ButtonGradient(
              onTap: () {
                context.go("/");
              },
              title: "Masuk",
            ),
          ],
        ),
      ),
    );
  }
}
