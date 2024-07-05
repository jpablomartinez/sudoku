import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class NumberButton extends StatelessWidget {
  final int value;
  final Function onTap;
  final bool active;
  const NumberButton({
    super.key,
    required this.value,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (active) {
          onTap();
        }
      },
      child: Container(
        height: size.height * 0.068,
        width: size.height * 0.068,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        decoration: BoxDecoration(
          color: active ? SudokuColors.onahu : SudokuColors.disabledCell,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: active ? SudokuColors.dodgerBlue : SudokuColors.disabledCell, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: active ? SudokuColors.dodgerBlueDarker : SudokuColors.disabledCell,
              offset: const Offset(0, 4),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Text(
            '$value',
            style: TextStyle(color: active ? SudokuColors.congressBlue : SudokuColors.disabledNumber, fontSize: 36),
          ),
        ),
      ),
    );
  }
}
