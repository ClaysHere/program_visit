// // ignore_for_file: depend_on_referenced_packages

// import 'package:flutter/material.dart';
// import 'package:program_visit/common/styles/color.dart';
// import 'package:program_visit/common/styles/font.dart';
// import 'package:program_visit/common/widgets/custom_tanggal.dart';
// import 'package:program_visit/utils/format_tanggal.dart';

// class InputFormDatetime extends StatefulWidget {
//   const InputFormDatetime({super.key, required this.onSelectedDateChanged});

//   final void Function(DateTime) onSelectedDateChanged;

//   @override
//   State<InputFormDatetime> createState() => _InputFormDatetimeState();
// }

// class _InputFormDatetimeState extends State<InputFormDatetime> {
//   DateTime? _selectedDate;
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     final double paddingHorizontal = screenWidth * 0.04;

//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           builder: (context) {
//             return Container(
//               height: screenHeight * 0.6,
//               padding: EdgeInsets.all(paddingHorizontal),
//               child: CustomTanggal(
//                 initialDate: _selectedDate ?? DateTime.now(),
//                 onSelectedDateChanged: (selectedDate) {
//                   setState(() {
//                     _selectedDate = selectedDate;
//                     _controller.text = formatTanggal(selectedDate);
//                   });
//                   widget.onSelectedDateChanged(selectedDate);
//                 },
//               ),
//             );
//           },
//         );
//       },
//       child: AbsorbPointer(
//         child: TextFormField(
//           controller: _controller,
//           style: TextStyle(fontFamily: "Poppins"),
//           decoration: InputDecoration(
//             hintText: "Masukkan tanggal daftar anda",
//             hintStyle: TextStyle(
//               fontFamily: "Poppins",
//               fontWeight: AppFontWeight.medium,
//               fontSize: 15,
//               color: const Color(0xff7F909F),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),

//             filled: true,
//             fillColor: AppColors.backgroundInputField,
//             contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//             suffixIcon: Padding(
//               padding: const EdgeInsets.all(12),
//               child: SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: Image.asset(
//                   "assets/icons/kalender.png",
//                   color: const Color(0xff7F909F),
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/color.dart'; // Pastikan path ini benar
import 'package:program_visit/common/styles/font.dart'; // Pastikan path ini benar
import 'package:program_visit/common/widgets/custom_tanggal.dart'; // Pastikan path ini benar
import 'package:program_visit/utils/format_tanggal.dart'; // Pastikan path ini benar

class InputFormDatetime extends StatefulWidget {
  const InputFormDatetime({
    super.key,
    required this.onSelectedDateChanged,
    this.selectedDate, // Parameter baru: tanggal yang sudah terpilih (opsional)
    this.hintText, // Parameter baru: teks petunjuk (opsional)
  });

  final void Function(DateTime) onSelectedDateChanged;
  final DateTime? selectedDate; // Tanggal yang dilewatkan dari widget induk
  final String? hintText; // Teks petunjuk untuk bidang input

  @override
  State<InputFormDatetime> createState() => _InputFormDatetimeState();
}

class _InputFormDatetimeState extends State<InputFormDatetime> {
  DateTime?
  _internalSelectedDate; // Status internal untuk mengelola tanggal yang terpilih
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi _internalSelectedDate dan teks controller berdasarkan selectedDate awal
    if (widget.selectedDate != null) {
      _internalSelectedDate = widget.selectedDate;
      _controller.text = formatTanggal(_internalSelectedDate!);
    }
  }

  @override
  void didUpdateWidget(covariant InputFormDatetime oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Perbarui status internal jika selectedDate dari widget induk berubah
    if (widget.selectedDate != oldWidget.selectedDate) {
      _internalSelectedDate = widget.selectedDate;
      _controller.text =
          _internalSelectedDate != null
              ? formatTanggal(_internalSelectedDate!)
              : ''; // Kosongkan jika selectedDate menjadi null
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                initialDate:
                    _internalSelectedDate ??
                    DateTime.now(), // Gunakan tanggal internal atau hari ini
                onSelectedDateChanged: (selectedDate) {
                  setState(() {
                    _internalSelectedDate = selectedDate;
                    _controller.text = formatTanggal(selectedDate);
                  });
                  widget.onSelectedDateChanged(
                    selectedDate,
                  ); // Panggil callback ke widget induk
                  Navigator.pop(
                    context,
                  ); // Tutup bottom sheet setelah tanggal dipilih
                },
              ),
            );
          },
        );
      },
      child: AbsorbPointer(
        // Mencegah keyboard muncul saat mengetuk TextFormField
        child: TextFormField(
          controller: _controller,
          style: const TextStyle(fontFamily: "Poppins"),
          decoration: InputDecoration(
            hintText:
                widget.hintText ??
                "Pilih tanggal", // Gunakan hintText dari parameter atau default
            hintStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: AppFontWeight.medium,
              fontSize: 15,
              color: Color(0xff7F909F),
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 15,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(
                  "assets/icons/kalender.png", // Pastikan path aset ini benar
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
