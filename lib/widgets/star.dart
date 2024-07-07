import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final bool isFull;
  final double height;
  const StarWidget({
    super.key,
    required this.isFull,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Image.asset(
        'assets/icons/star2.png',
        height: height,
        color: isFull ? Color.fromARGB(255, 221, 218, 46) : const Color(0xff074793),
      ),
    );
  }
}
