import 'package:flutter/material.dart';

class LoginController {
  // final TextEditingController username =
  bool enablePassword = true;

  void togglePasswordVisibility(Function updateState) {
    updateState(() {
      enablePassword = !enablePassword;
    });
  }

  Future<void> login(BuildContext context) async {}
}
