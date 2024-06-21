import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku/colors.dart';

class NumberButton extends StatelessWidget {
  final int value;
  final Function onTap;
  const NumberButton({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        width: 57,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        decoration: BoxDecoration(
          color: SudokuColors.onahu,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: SudokuColors.dodgerBlue, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: SudokuColors.dodgerBlueDarker,
              offset: Offset(0, 4),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: DefaultTextStyle(
            style: GoogleFonts.gluten(color: SudokuColors.congressBlue, fontSize: 36),
            child: Text('$value'),
          ),
        ),
      ),
    );
  }
}
