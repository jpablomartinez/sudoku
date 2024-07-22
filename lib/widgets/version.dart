import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

const String version = '0.5.1';

class VersionApp extends StatelessWidget {
  final double fontSize;
  final Size size;

  const VersionApp({
    super.key,
    required this.size,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'JK STUDIOS - Version $version',
          style: TextStyle(
            color: SudokuColors.congressBlue,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
