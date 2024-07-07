import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class SquareSeletorButton extends StatelessWidget {
  final String title;
  final String content;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final bool isSelected;
  final Function onTap;
  final Size size;

  const SquareSeletorButton({
    super.key,
    required this.title,
    required this.content,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          border: Border.all(color: isSelected ? borderColor : backgroundColor, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: SudokuColors.onahu.withOpacity(0.8),
              offset: const Offset(0, 4),
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
