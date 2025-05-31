// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:program_visit/common/widgets/custom_appbar.dart';

// class AkunScreen extends StatelessWidget {
//   const AkunScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;

//     final double paddingHorizontal = screenWidth * 0.04;
//     final double verticalSpacing = screenHeight * 0.02;
//     return Scaffold(
//       appBar: CustomAppbar(
//         onTap: () {
//           context.go("/");
//         },
//         nama: "Pengaturan Akun",
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(
//           horizontal: paddingHorizontal,
//           vertical: verticalSpacing,
//         ),
//         children: [
//           Container(
//             height: 50,
//             color: Colors.amber[600],
//             child: const Center(child: Text('Entry A')),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/widgets/bottom_navbar.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';
import 'package:program_visit/features/authentication/controller/logout_controller.dart';

class AkunScreen extends StatelessWidget {
  AkunScreen({super.key});

  final LogoutController controller = LogoutController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final double paddingHorizontal = screenWidth * 0.04;

    return Scaffold(
      appBar: CustomAppbar(
        onTap: () {
          context.go("/");
        },
        nama: "Pengaturan akun",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        children: [
          _SettingItem(
            icon: Icons.logout,
            title: 'Keluar',
            subtitle: 'Yakin mau keluar? Pas balik harus masuk akun lagi, ya.',
            onTap: () {
              controller.logout(context);
            },
          ),
          const SizedBox(height: 16),
          _SettingItem(
            icon: Icons.delete,
            title: 'Hapus akun',
            subtitle:
                'Akunmu akan dihapus secara permanen. Jadi, kamu gak bisa lagi akses riwayat dari akunmu.',
            onTap: () {
              // Navigasi atau aksi hapus akun
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: screenWidth * 0.02,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
