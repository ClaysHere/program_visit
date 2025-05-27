// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:program_visit/features/service/api_service.dart';

// class RegisterController {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   // Tambahkan controller lain jika diperlukan untuk registrasi penuh
//   // final TextEditingController firstNameController = TextEditingController();
//   // final TextEditingController lastNameController = TextEditingController();

//   bool enablePassword = true;

//   void togglePasswordVisibility(Function updateState) {
//     updateState(() {
//       enablePassword = !enablePassword;
//     });
//   }

//   Future<void> register(BuildContext context) async {
//     final username = usernameController.text;
//     final email = emailController.text;
//     final password = passwordController.text;

//     if (username.isEmpty || email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Semua bidang harus diisi')));
//       return;
//     }

//     final authResponse = await ApiService.register(
//       username,
//       email,
//       password,
//       // firstName: firstNameController.text, // Contoh penggunaan
//       // lastName: lastNameController.text,
//       userType: 'Customer', // Contoh: Tetapkan userType default saat registrasi
//     );

//     if (authResponse != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
//       );
//       context.go('/login'); // Kembali ke halaman login setelah registrasi
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registrasi gagal. Silakan coba lagi.')),
//       );
//     }
//   }

//   void dispose() {
//     usernameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     // firstNameController.dispose();
//     // lastNameController.dispose();
//   }
// }
