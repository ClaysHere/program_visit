import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final void Function()? onPressedBack;
  final String label;
  final void Function()? onPressedNext;

  const Pagination({
    super.key,
    this.onPressedBack,
    required this.label,
    this.onPressedNext,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: widget.onPressedBack,
        ),
        Text(
          widget.label,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: widget.onPressedNext,
        ),
      ],
    );
  }
}
