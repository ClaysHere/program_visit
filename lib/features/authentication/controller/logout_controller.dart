// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/features/service/api_service.dart';
import 'package:program_visit/utils/loading_helper.dart';
import 'package:program_visit/utils/snackbar_helper.dart'; // Diasumsikan ini menampilkan dan menyembunyikan dialog loading Anda

class LogoutController {
  Future<void> logout(BuildContext context) async {
    // Tampilkan indikator loading
    showLoadingDialog(context);

    try {
      final success = await ApiService.logout();

      // Sembunyikan indikator loading setelah panggilan API, terlepas dari berhasil atau gagal
      // Sangat penting untuk menyembunyikannya sebelum menampilkan elemen UI lain seperti snackbar
      // atau menavigasi, jika tidak dialog mungkin akan memblokirnya.
      // Tutup dialog loading
      Navigator.of(context, rootNavigator: true).pop();

      if (success) {
        SnackbarHelper.showSuccess(context, 'Anda berhasil logout');

        context.go('/login');
      } else {
        SnackbarHelper.showError(context, 'Logout gagal. Silakan coba lagi');
      }
    } catch (e) {
      // Pastikan dialog loading ditutup meskipun terjadi error
      // Tutup dialog loading
      Navigator.of(context, rootNavigator: true).pop();

      SnackbarHelper.showError(context, 'Terjadi kesalahan: ${e.toString()}');
    } finally {
      hideLoadingDialog(context);
    }
  }
}
