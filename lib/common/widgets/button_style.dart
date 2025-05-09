import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/color.dart';

class ButtonGradient extends StatelessWidget {
  const ButtonGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -18,
              bottom: -38,
              child: Image.asset("assets/icons/big.png", width: 75, height: 75),
            ),
            Positioned(
              right: 15,
              top: 42,
              child: Image.asset(
                "assets/icons/extra-small.png",
                width: 10,
                height: 10,
              ),
            ),
            Positioned(
              right: 50,
              bottom: 40,
              child: Image.asset(
                "assets/icons/medium.png",
                width: 27,
                height: 27,
              ),
            ),
            Positioned(
              right: 90,
              bottom: 20,
              child: Image.asset(
                "assets/icons/small.png",
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
