import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;
  final Function onTap;
  final Widget icon;

  const SquareButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.labelColor,
    required this.label,
    required this.onTap,
    this.icon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 58,
        width: 230,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: 2,
            ),
            top: BorderSide(
              color: borderColor,
              width: 1,
            ),
            left: BorderSide(
              color: borderColor,
              width: 1,
            ),
            right: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: SudokuColors.onahu,
              ),
              child: icon,
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
