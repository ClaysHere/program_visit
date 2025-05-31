import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/widgets/bottom_navbar.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onTap: () {
          context.go("/");
        },
        nama: "Atur Jadwal",
      ),
      body: Center(child: Text("Hello World")),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
