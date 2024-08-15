import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

const String version = '0.7.0';

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
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        alignment: Alignment.bottomCenter,
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
