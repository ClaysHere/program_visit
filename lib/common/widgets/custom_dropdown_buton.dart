import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart'; // Pastikan path ini benar

// Jadikan widget ini generik dengan <T>
class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    this.value, // Sekarang tipe T?
    required this.items, // Sekarang List<DropdownMenuItem<T>>?
    required this.onChanged, // Sekarang void Function(T?)?
    this.hintText, // Tambahkan parameter hintText
  });

  final T? value; // Nilai yang dipilih, tipenya generik T
  final List<DropdownMenuItem<T>> items; // Daftar item, tipenya generik T
  final void Function(T?)?
  onChanged; // Callback saat nilai berubah, tipenya generik T
  final String? hintText; // Teks petunjuk untuk dropdown

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  // selectedValue sekarang akan diinisialisasi dari widget.value
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value; // Inisialisasi dari nilai awal
  }

  @override
  void didUpdateWidget(covariant CustomDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Perbarui _selectedValue jika nilai dari parent berubah
    if (widget.value != oldWidget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 11,
        horizontal: 15,
      ), // Tambahkan horizontal padding agar sesuai dengan input lain
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8), // Sama seperti TextFormField
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          // Pastikan tipe generik T di sini
          isExpanded: true,
          hint: Text(
            widget.hintText ??
                'Pilih Opsi', // Gunakan hintText dari parameter atau default
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
              fontWeight: AppFontWeight.medium,
              color: Color(0xff7F909F),
            ),
          ),
          items: widget.items, // Gunakan items dari parameter widget
          value: _selectedValue, // Gunakan _selectedValue internal
          onChanged: (T? value) {
            // Pastikan callback meneruskan tipe T?
            setState(() {
              _selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(
                value,
              ); // Panggil callback yang diberikan dari parent
            }
          },
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),
          buttonStyleData: const ButtonStyleData(
            // padding: EdgeInsets.symmetric(horizontal: 16), // Padding horizontal sudah diatur di Container
            width: double.infinity,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        ),
      ),
    );
  }
}
