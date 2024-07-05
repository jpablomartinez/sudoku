import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class UnderlineButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const UnderlineButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        height: 60,
        width: 230,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/point.png'),
                const SizedBox(width: 60),
                Text(
                  label,
                  style: const TextStyle(
                    color: SudokuColors.congressBlue,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/red-underline.png'),
          ],
        ),
      ),
    );
  }
}
