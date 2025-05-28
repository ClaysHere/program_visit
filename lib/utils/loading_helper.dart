import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    // Pengguna tidak bisa menutup dialog dengan tap di luar
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        // Menggunakan PopScope untuk mencegah penutupan dialog dengan tombol kembali
        canPop: false, // Mencegah dialog ditutup dengan tombol kembali
        child: Dialog(
          backgroundColor:
              Colors.transparent, // Membuat latar belakang dialog transparan
          elevation: 0, // Menghilangkan bayangan
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      );
    },
  );
}

/// Fungsi untuk menyembunyikan dialog loading yang sedang aktif.
/// Memastikan context masih mounted sebelum mencoba menutup dialog.
void hideLoadingDialog(BuildContext context) {
  // Pastikan context masih mounted sebelum mencoba pop
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}
