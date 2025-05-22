import 'package:flutter/material.dart';

class ArrowBack extends StatefulWidget {
  const ArrowBack({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<ArrowBack> createState() => _ArrowBackState();
}

class _ArrowBackState extends State<ArrowBack> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Image.asset("assets/icons/arrow-back.png"),
    );
  }
}
