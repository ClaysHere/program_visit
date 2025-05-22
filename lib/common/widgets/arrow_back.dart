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
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: Color(0XFF7F909F)),
      ),
      height: 20,
      width: 20,
      child: InkWell(
        onTap: widget.onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Image.asset(
          "assets/icons/arrow-back.png",
          width: 15,
          height: 15,
        ),
      ),
    );
  }
}
