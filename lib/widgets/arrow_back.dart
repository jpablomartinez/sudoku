import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class ArrowBack extends StatelessWidget {
  final Function onTap;

  const ArrowBack({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: SudokuColors.onahu,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/arrow2.png',
            height: 17,
            color: const Color(0xff3B95FF),
          ),
        ),
      ),
    );
  }
}
