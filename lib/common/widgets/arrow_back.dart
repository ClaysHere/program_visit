import 'package:flutter/material.dart';

class ArrowBack extends StatefulWidget {
  const ArrowBack({super.key, required this.onTap, this.width, this.height});

  final void Function()? onTap;
  final double? width;
  final double? height;

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
      child: Image.asset(
        "assets/icons/arrow-back.png",
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
