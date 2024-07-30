import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class TitleScreen extends StatelessWidget {
  final String title;

  const TitleScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.61,
      height: 45,
      decoration: BoxDecoration(
        color: SudokuColors.onahu,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xff9FC6F3),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: SudokuColors.dodgerBlueDarker,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
