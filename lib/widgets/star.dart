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
        isFull ? 'assets/icons/star.png' : 'assets/icons/_empty-star.png',
        height: height,
      ),
    );
  }
}
