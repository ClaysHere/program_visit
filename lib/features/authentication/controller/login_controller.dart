// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/features/service/api_service.dart';
import 'package:program_visit/utils/loading_helper.dart';
import 'package:program_visit/utils/snackbar_helper.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool enablePassword = true;

  void togglePasswordVisibility(Function updateState) {
    updateState(() {
      enablePassword = !enablePassword;
    });
  }

  Future<void> login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      SnackbarHelper.showError(
        context,
        'Username dan Password tidak boleh kosong',
      );
      return;
    }

    showLoadingDialog(context);

    try {
      final authResponse = await ApiService.login(username, password);

      if (!context.mounted) return;

      if (authResponse != null) {
        SnackbarHelper.showSuccess(context, 'Login berhasil');
        // Arahkan ke halaman utama atau halaman berdasarkan user_type
        if (authResponse.user.userType == 'Admin' ||
            authResponse.user.userType == "SuperAdmin") {
          context.go('/');
        } else if (authResponse.user.userType == 'Sales') {
          // context.go('/sales_dashboard'); // Contoh: rute khusus sales
        } else {
          // context.go('/user_dashboard'); // Contoh: rute khusus customer/user biasa
        }
      } else {
        SnackbarHelper.showError(
          context,
          'Login gagal. Periksa username dan password Anda.',
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      SnackbarHelper.showError(
        context,
        'Terjadi kesalahan. Silakan coba lagi nanti. ($e)',
      );
    } finally {
      // --- HENTIKAN LOADING DI SINI ---
      // Pastikan isLoading selalu diatur ke false setelah operasi selesai,
      // baik berhasil, gagal, maupun terjadi error dalam try/catch.
      hideLoadingDialog(context);
    }
  }

  Future<void> logout(BuildContext context) async {
    final success = await ApiService.logout();
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Anda telah logout.')));
      context.go('/login'); // Arahkan kembali ke halaman login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout gagal. Silakan coba lagi.')),
      );
    }
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
