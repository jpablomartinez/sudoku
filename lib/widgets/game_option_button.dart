import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class GameOptionButton extends StatelessWidget {
  final String title;
  final String content;
  final bool isSelected;
  final Function onTap;

  const GameOptionButton({
    super.key,
    required this.title,
    required this.content,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Row(
          children: [
            isSelected
                ? Image.asset(
                    'assets/icons/check.png',
                    width: 30,
                  )
                : const SizedBox(
                    width: 30,
                  ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: SudokuColors.firefly,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.70,
                  child: Text(
                    content,
                    style: const TextStyle(
                      color: SudokuColors.firefly,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      height: 16 / 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
