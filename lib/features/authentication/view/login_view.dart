import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/button_gradient.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';
import 'package:program_visit/features/authentication/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/banner-login.png",
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.25,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              CustomTextStyle(
                text: "Selamat Datang di VisitApp",
                fontSize: screenWidth * 0.05,
                fontWeight: AppFontWeight.bold,
              ),

              SizedBox(height: screenHeight * 0.015),

              CustomTextStyle(
                text:
                    "Masukkan username dan password anda \nuntuk menjelajahi aplikasi ini",
                fontSize: screenWidth * 0.035,
                fontWeight: AppFontWeight.regular,
              ),

              SizedBox(height: screenHeight * 0.035),

              Label(text: "Username", simbol: " *"),
              SizedBox(height: screenHeight * 0.01),
              InputForm(
                controller: controller.usernameController,
                obscureText: false,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    "assets/icons/user.png",
                    width: 22,
                    height: 22,
                  ),
                ),
                hintText: "Masukkan Username Anda",
              ),

              SizedBox(height: screenHeight * 0.02),

              Label(text: "Password", simbol: " *"),
              SizedBox(height: screenHeight * 0.01),
              InputForm(
                controller: controller.passwordController,
                obscureText: controller.enablePassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
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
                    controller.togglePasswordVisibility(setState);
                  },
                  icon: Icon(
                    controller.enablePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xff7f909f),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              ButtonGradient(
                onTap: () {
                  controller.login(context);
                },
                title: "Masuk",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
