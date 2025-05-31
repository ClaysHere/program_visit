import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';

class CustomDropdownButon extends StatefulWidget {
  const CustomDropdownButon({super.key});

  @override
  State<CustomDropdownButon> createState() => _CustomDropdownButonState();
}

class _CustomDropdownButonState extends State<CustomDropdownButon> {
  final List<String> items = ['Sales', 'Admin'];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8), // Sama seperti TextFormField
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Pilih nama user yang didaftarkan',
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
              fontWeight: AppFontWeight.medium,
              color: Color(0xff7F909F),
            ),
          ),
          items:
              items
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    ),
                  )
                  .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        ),
      ),
    );
  }
}
