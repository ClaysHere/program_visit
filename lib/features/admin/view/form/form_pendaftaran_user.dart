// views/form_pendaftaran_user.dart
// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/bottom_navbar.dart';
import 'package:program_visit/common/widgets/custom_appbar.dart';
import 'package:program_visit/common/widgets/custom_dropdown_buton.dart'; // Import CustomDropdownButton yang sudah diperbaiki
import 'package:program_visit/common/widgets/custom_text_style.dart';
import 'package:program_visit/common/widgets/datetime_input_form.dart';
import 'package:program_visit/common/widgets/input_form.dart';
import 'package:program_visit/common/widgets/label.dart';
import 'package:program_visit/features/admin/models/register_user_model.dart';
import 'package:program_visit/features/service/api_service.dart';
import 'package:program_visit/utils/snackbar_helper.dart';

class FormPendaftaranUser extends StatefulWidget {
  const FormPendaftaranUser({super.key});

  @override
  State<FormPendaftaranUser> createState() => _FormPendaftaranUserState();
}

class _FormPendaftaranUserState extends State<FormPendaftaranUser> {
  bool enablePassword = true;
  DateTime? _selectedJoinDate;
  DateTime? _selectedBirthDate;
  UserType? _selectedUserType;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();

  void _onSelectedJoinDateChanged(DateTime date) {
    setState(() {
      _selectedJoinDate = date;
    });
  }

  void _onSelectedBirthDateChanged(DateTime date) {
    setState(() {
      _selectedBirthDate = date;
    });
  }

  Future<void> _registerUser() async {
    if (_selectedUserType == null ||
        _selectedJoinDate == null ||
        _selectedBirthDate == null ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _birthPlaceController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _religionController.text.isEmpty) {
      SnackbarHelper.showError(
        context,
        'Harap isi semua kolom yang wajib diisi.',
      );
      return;
    }

    final RegisterUserModel? newUser = await ApiService.registerAdminDanSales(
      username: _usernameController.text,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      userType: _selectedUserType!,
      gender: _genderController.text,
      birthPlace: _birthPlaceController.text,
      birthDate: _selectedBirthDate!,
      address: _addressController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      city: _cityController.text,
      religion: _religionController.text,
      joinDate: _selectedJoinDate!,
      isSuspended: false,
    );

    if (newUser != null) {
      SnackbarHelper.showSuccess(
        context,
        'Pengguna ${newUser.username} berhasil terdaftar!',
      );
      context.go('/');
    } else {
      SnackbarHelper.showError(
        context,
        'Gagal mendaftarkan pengguna. Silakan coba lagi.',
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _birthPlaceController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _religionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final double paddingHorizontal = screenWidth * 0.04;
    final double verticalSpacing = screenHeight * 0.02;
    final bool isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: CustomAppbar(
        onTap: () {
          context.go("/");
        },
        nama: "Pendaftaran User",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: _registerUser,
              child: CustomTextStyle(
                text: "Simpan",
                fontSize: 17,
                fontWeight: AppFontWeight.medium,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: paddingHorizontal,
          right: paddingHorizontal,
          top: verticalSpacing,
          bottom: verticalSpacing * 0.5,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(text: "Pilih User"),
                  SizedBox(height: verticalSpacing * 0.25),
                  // Pemanggilan CustomDropdownButton untuk UserType
                  CustomDropdownButton<UserType>(
                    value: _selectedUserType,
                    items:
                        UserType.values.map((UserType type) {
                          return DropdownMenuItem<UserType>(
                            value: type,
                            child: Text(type.name.capitalize()),
                          );
                        }).toList(),
                    hintText: "Pilih Tipe User",
                    onChanged: (UserType? newValue) {
                      setState(() {
                        _selectedUserType = newValue;
                      });
                    },
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Nama Depan"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan nama depan Anda",
                    controller: _firstNameController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Nama Belakang"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan nama belakang Anda",
                    controller: _lastNameController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Username"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan username Anda",
                    controller: _usernameController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Password"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan password Anda",
                    controller: _passwordController,
                    obscureText: enablePassword,
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          enablePassword = !enablePassword;
                        });
                      },
                      icon: Icon(
                        enablePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xff7f909f),
                        size: isSmallScreen ? 20 : 24,
                      ),
                    ),
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Tanggal Daftar"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputFormDatetime(
                    onSelectedDateChanged: _onSelectedJoinDateChanged,
                    selectedDate: _selectedJoinDate,
                    hintText: "Masukkan tanggal daftar Anda",
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Alamat"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan alamat Anda",
                    controller: _addressController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Email"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan email Anda",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Jenis Kelamin"),
                  SizedBox(height: verticalSpacing * 0.25),
                  // Pemanggilan CustomDropdownButton untuk String (Jenis Kelamin)
                  CustomDropdownButton<String>(
                    value:
                        _genderController.text.isNotEmpty
                            ? _genderController.text
                            : null,
                    items: const [
                      DropdownMenuItem(
                        value: 'Laki-laki',
                        child: Text('Laki-laki'),
                      ),
                      DropdownMenuItem(
                        value: 'Perempuan',
                        child: Text('Perempuan'),
                      ),
                    ],
                    hintText: "Pilih jenis kelamin",
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _genderController.text = newValue;
                        });
                      }
                    },
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Tempat Lahir"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan tempat lahir Anda",
                    controller: _birthPlaceController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Tanggal Lahir"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputFormDatetime(
                    onSelectedDateChanged: _onSelectedBirthDateChanged,
                    selectedDate: _selectedBirthDate,
                    hintText: "Masukkan tanggal lahir Anda",
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Kota"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan kota Anda",
                    controller: _cityController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "Agama"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan agama Anda",
                    controller: _religionController,
                  ),

                  SizedBox(height: verticalSpacing),

                  const Label(text: "No Handphone"),
                  SizedBox(height: verticalSpacing * 0.25),
                  InputForm(
                    hintText: "Masukkan nomor handphone Anda",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: verticalSpacing),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
