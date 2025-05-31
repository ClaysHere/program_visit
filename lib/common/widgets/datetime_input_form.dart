// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/color.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_tanggal.dart';
import 'package:program_visit/utils/format_tanggal.dart';

class InputFormDatetime extends StatefulWidget {
  const InputFormDatetime({super.key, required this.onSelectedDateChanged});

  final void Function(DateTime) onSelectedDateChanged;

  @override
  State<InputFormDatetime> createState() => _InputFormDatetimeState();
}

class _InputFormDatetimeState extends State<InputFormDatetime> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final double paddingHorizontal = screenWidth * 0.04;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: screenHeight * 0.6,
              padding: EdgeInsets.all(paddingHorizontal),
              child: CustomTanggal(
                initialDate: _selectedDate ?? DateTime.now(),
                onSelectedDateChanged: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                    _controller.text = formatTanggal(selectedDate);
                  });
                  widget.onSelectedDateChanged(selectedDate);
                },
              ),
            );
          },
        );
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          style: TextStyle(fontFamily: "Poppins"),
          decoration: InputDecoration(
            hintText: "Masukkan tanggal daftar anda",
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: AppFontWeight.medium,
              fontSize: 15,
              color: const Color(0xff7F909F),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            filled: true,
            fillColor: AppColors.backgroundInputField,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(
                  "assets/icons/kalender.png",
                  color: const Color(0xff7F909F),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
